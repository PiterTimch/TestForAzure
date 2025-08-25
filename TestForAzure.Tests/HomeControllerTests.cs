using TestForAzure.Controllers;
using Xunit;
using Microsoft.Extensions.Logging.Abstractions;

namespace TestForAzure.Tests;

public class HomeControllerTests
{
    [Fact]
    public void AddTest_ReturnsCorrectSum()
    {
        // Arrange
        var logger = new NullLogger<HomeController>();
        var controller = new HomeController(logger);

        // Act
        int result = controller.AddTest(2, 3);

        // Assert
        Assert.Equal(5, result);
    }
}
