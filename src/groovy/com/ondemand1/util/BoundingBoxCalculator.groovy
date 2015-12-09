package com.ondemand1.util;
class BoundingBoxCalculator {

    BoundingBoxCalculator (double centerLat, double centerLon, double radius)

    {
        this.centerLat = centerLat;
        this.centerLon = centerLon;
        //multiply by sqrt 2 to inscribe the circle in the bounding box
        this.radius = radius * sqrt2;
    }
 
    public double[] calculateUpperLeftCoordinate()
    {
        return  calculateCoordinateVincenty(centerLat, centerLon, 315, radius);
    }

    public double[] calculateLowerRightCoordinate()
    {
        return  calculateCoordinateVincenty(centerLat, centerLon, 135, radius);
    }

    /*
     * Calculate destination point given start point lat/long (numeric degrees),
     * bearing (numeric degrees) & distance (in m).
     *
     * from: Vincenty direct formula - T Vincenty, "Direct and Inverse Solutions of Geodesics on the
     *       Ellipsoid with application of nested equations", Survey Review, vol XXII no 176, 1975
     *       http://www.ngs.noaa.gov/PUBS_LIB/inverse.pdf
     *
     * implementation: Ported is based on Chris Veness code
     */
    private double[] calculateCoordinateVincenty(double lat1, double lon1, int bearing, double distance) {
        double majorSemiAxis = 6378137, minorSemiAxis = 6356752.3142,  flattening = 1/298.257223563;  // WGS-84 ellipsiod
        //double s = distance;
        double alpha1 = toRadian(bearing);
        double sinAlpha1 = Math.sin(alpha1), cosAlpha1 = Math.cos(alpha1);
        double tanU1 = (1-flattening ) * Math.tan( toRadian(lat1));
        double cosU1 = 1 / Math.sqrt((1 + tanU1*tanU1)), sinU1 = tanU1*cosU1;
        double sigma1 = Math.atan2(tanU1, cosAlpha1);
        double sinAlpha = cosU1 * sinAlpha1;
        double cosSqAlpha = 1 - sinAlpha*sinAlpha;
        double uSq = cosSqAlpha * (majorSemiAxis*majorSemiAxis - minorSemiAxis*minorSemiAxis) / (minorSemiAxis*minorSemiAxis);
        double A = 1 + uSq/16384*(4096+uSq*(-768+uSq*(320-175*uSq)));
        double B = uSq/1024 * (256+uSq*(-128+uSq*(74-47*uSq)));
        double sigma = distance / (minorSemiAxis*A), sigmaP = 2*Math.PI;
        double sinSigma = 0, cosSigma =0, cos2SigmaM = 0;
        while (Math.abs(sigma-sigmaP) > 1e-12) {
            cos2SigmaM = Math.cos(2*sigma1 + sigma);
            sinSigma = Math.sin(sigma);
            cosSigma = Math.cos(sigma);
            double deltaSigma = B*sinSigma*(cos2SigmaM+B/4*(cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)-
                    B/6*cos2SigmaM*(-3+4*sinSigma*sinSigma)*(-3+4*cos2SigmaM*cos2SigmaM)));
            sigmaP = sigma;
            sigma = distance / (minorSemiAxis*A) + deltaSigma;
        }

        double tmp = sinU1*sinSigma - cosU1*cosSigma*cosAlpha1;
        double lat2 = Math.atan2(sinU1*cosSigma + cosU1*sinSigma*cosAlpha1,
                (1-flattening )*Math.sqrt(sinAlpha*sinAlpha + tmp*tmp));
        double lambda = Math.atan2(sinSigma*sinAlpha1, cosU1*cosSigma - sinU1*sinSigma*cosAlpha1);
        double C = flattening /16*cosSqAlpha*(4+flattening *(4-3*cosSqAlpha));
        double L = lambda - (1-C) * flattening  * sinAlpha *
                (sigma + C*sinSigma*(cos2SigmaM+C*cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)));
        //double revAz = Math.atan2(sinAlpha, -tmp);  // final bearing
        return [toDegree(lat2), lon1+toDegree(L)];
    }

    private double toRadian(double degree)
    {
        return degree * ( Math.PI / 180 );
    }

 

    private double toDegree(double radian)
    {
        return radian * (180 / Math.PI );
    }

    private double centerLat =0, centerLon =0, radius = 0;
    private static double sqrt2 = Math.sqrt(2d);
    public static double METERS_PER_MILE = 1609.344 

}
