let config = {
  address: "0.0.0.0",
  port: 8080,
  basePath: "/",
  ipWhitelist: [],
  useHttps: false,
  language: "de",
  locale: "de-DE",
  timeFormat: 24,
  units: "metric",
  watchTargets: ["config/config.js"],
  modules: [
    {
      module: "clock",
      position: "top_left",
      config: {
        displayType: "digital",
        showDate: true,
        showWeek: true,
      },
    },
    {
      module: "MMM-AhaAbfuhr",
      position: "top_right",
      config: {
        municipality: process.env.AHA_MUNICIPALITY,
        street: process.env.AHA_STREET,
        houseNumber: process.env.AHA_HOUSE_NUMBER,
        houseNumberSuffix: process.env.AHA_HOUSE_NUMBER_SUFFIX || "",
        daysToShow: 21,
        maxEntries: 8,
        showAddress: false,
      },
    },
  ],
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {
  module.exports = config;
}
