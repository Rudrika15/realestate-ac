const express = require('express')
const cors = require('cors')
const swaggerUi = require('swagger-ui-express')
const swaggerDocs = require('./swagger')
const path = require('path')
const http = require('http')

const app = express()
const httpServer = http.createServer(app)

// CORS configuration
const corsOptions = {
  origin: ['https://realestate.flipcodesolutions.com', 'http://localhost:3000'], // Allow all origins (for production, replace with specific URLs)
  methods: ['GET', 'POST', 'PUT', 'DELETE'], // Restrict allowed methods
  credentials: true, // Enable set cookie
  optionsSuccessStatus: 200 // For legacy browsers
}

app.use(cors(corsOptions))

// Body Parsers
app.use(express.json())
app.use(express.urlencoded({ extended: false }))

// Trust Proxy (for proxy servers like Nginx)
app.set('trust proxy', true)

// CORS Test Routes
app.get('/simple-cors', (req, res) => {
  console.info('GET /simple-cors')
  res.json({
    text: 'Simple CORS requests are working. [GET]'
  })
})

app.post('/simple-cors', (req, res) => {
  console.info('POST /simple-cors')
  res.json({
    text: 'Simple CORS requests are working. [POST]'
  })
})

// Routes Import
const userRoutes = require('./routes/userRoutes')
const roleRoutes = require('./routes/roleRoutes')
const permissionRoutes = require('./routes/permissionRouter')
const rolePermissionRoutes = require('./routes/rolePermissionRouter')
const partnerRoute = require('./routes/partnerRoute')
const projectRoute = require('./routes/projectRoute')
const brokerRoute = require('./routes/brokerRoute')
const authMiddleware = require('./middlewares/authMiddelware')
const authenticateToken = require('./middlewares/authenticateToken')
const projectStageRoute = require('./routes/projectStageRoute')
const bookingRoute = require('./routes/bookingRoute')
const expenseRoute = require('./routes/expenseRoute')
const partnerIncomeRoute = require('./routes/partnerIncomeRoute')
const scrapIncomeRoute = require('./routes/scrapIncomeRoute')
const installmentRoute = require('./routes/installmentRoute')
const incomeBookingRoute = require('./routes/IncomeBookingRoute')

// API Routes
app.use('/api/v1/users', userRoutes)
app.use('/api/v1/roles', authMiddleware, authenticateToken, roleRoutes)
app.use(
  '/api/v1/permissions',
  authMiddleware,
  authenticateToken,
  permissionRoutes
)
app.use(
  '/api/v1/roles-permissions',
  authMiddleware,
  authenticateToken,
  rolePermissionRoutes
)
app.use('/api/v1/partner', authMiddleware, authenticateToken, partnerRoute)
app.use('/api/v1/projects', authMiddleware, authenticateToken, projectRoute)

app.use('/api/v1/brokers', authMiddleware, authenticateToken, brokerRoute)

app.use(
  '/api/v1/projectstage',
  authMiddleware,
  authenticateToken,
  projectStageRoute
)

app.use('/api/v1/bookings', authMiddleware, authenticateToken, bookingRoute)

// expense route
app.use('/api/v1/expense', authMiddleware, authenticateToken, expenseRoute)

app.use(
  '/api/v1/partnerIncome',
  authMiddleware,
  authenticateToken,
  partnerIncomeRoute
)
app.use(
  '/api/v1/scrapIncome',
  authMiddleware,
  authenticateToken,
  scrapIncomeRoute
)
app.use(
  '/api/v1/installment/',
  authMiddleware,
  authenticateToken,
  installmentRoute
)

app.use(
  '/api/v1/incomeBooking',
  authMiddleware,
  authenticateToken,
  incomeBookingRoute
)
// Swagger Documentation
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs))

// Welcome Route
app.get('/', (req, res) => {
  res.send('Welcome to the API! Visit /api-docs for documentation.')
})

// 404 Error Handler
app.use((req, res) => {
  res.status(404).json({ message: 'Endpoint not found' })
})

// Start Server
const PORT = process.env.PORT || 3000
httpServer.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`)
  console.log(`Swagger Docs available at http://localhost:${PORT}/api-docs`)
})
