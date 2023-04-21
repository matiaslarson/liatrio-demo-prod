package main

import (
	"time"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.String(200, "Cloudy with a chance of containers")
	})

	api := r.Group("/api")

	api.GET("/demo", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message":   "Automate all the things!",
			"timestamp": time.Now().Unix(),
		})
	})

	r.Run()
}
