import React, { Component } from 'react';
import Web3 from 'web3'
import './App.css';
import Color from '../abis/Color.json'
import background from "../img/tile002.png";
import Dialog from 'react-bootstrap-dialog'
import images from '../components/images'
import ReactTooltip from "react-tooltip";



class App extends Component {

 


  
  

  async componentWillMount() {
    await this.loadWeb3()
    await this.loadBlockchainData()
  }

 
  onClickCreateDialog () {
 
   // setInterval('window.location.reload()', 60000); //1 min


    //this.dialog.showAlert('Congrat!! Now You can feed, train and make your mecha the best in blockchain history')
  }

  updateClick() {
 


   // setInterval('window.location.reload()', 60000); //1 min
   window.location.reload()

   // this.dialog.showAlert('Congrat!! Now You can feed, train and make your mecha the best in blockchain history')
  }



  async loadWeb3() {
    if (window.ethereum) {
      window.web3 = new Web3(window.ethereum)
      await window.ethereum.enable()
    }
    else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider)
    }
    else {
      window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!')
    }
  }

  async loadBlockchainData() {
    const web3 = window.web3
    // const nn =  web3.utils.hexToNumberString(this.color.id);
  // const weiValue =  web3.eth.toWei(0.007,'ether');
    // Load account
    const accounts = await web3.eth.getAccounts()
    this.setState({ account: accounts[0] })

 
  //const planet = ""
    const networkId = await web3.eth.net.getId()
    const networkData = Color.networks[networkId]
    if(networkData) {
      const abi = Color.abi
      const address = networkData.address
      const contract = new web3.eth.Contract(abi, address)
      this.setState({ contract })
      const totalSupply = await contract.methods.totalSupply().call()
      this.setState({ totalSupply })
            const colorlevel = await contract.methods.digitmon(0).call()
      this.setState({ colorlevel })
      // Load Colors
      for (var i = 1; i <= totalSupply; i++) {
        const color = await contract.methods.digitmon(i - 1).call()
        this.setState({
          colors: [...this.state.colors, color]
        })
      }
    } else {
      window.alert('Smart contract not deployed to detected network.')
    }
  }
  
  mint = (color, gender, haircolor,eyecolor, headcolor,secret) => {         //send({ from: this.state.account, value:0.007*10**18 }) for payment
    this.state.contract.methods.mint(color, gender, haircolor,eyecolor, headcolor,secret).send({ from: this.state.account, value:0.03*10**18 })
    .once('receipt', (receipt ) => { 
      this.setState({
      
        colors: [...this.state.colors, color]

      })
      
    })
    
  }

 
  constructor(props) {
    super(props)
    this.onClickCreateDialog = this.onClickCreateDialog.bind(this);
     this.updateClick = this.updateClick.bind(this);
   
    this.state = {
      account: '',
      contract: null,
      totalSupply: 0,
      colors: [],
       showMenu: false,
      colorlevel: 0
    }
     
    
  }

  render() {
    return (
    
    
  
    
    


      <div className="back">
     

      
        <nav className="navbar navbar-light fixed-top bg-light flex-md-nowrap p-0 shadow">
          <a  style={{ backgroundColor:"#FFB261" }}
            className="navbar-brand col-sm-3 col-md-2 mr-0"
            href="https://twitter.com/DigitalPets1" // change to twitter address
            target="_blank"
            rel="noopener noreferrer"
          >

            <div className="text-white">Crypto Sims</div>

          
          </a>

           <a  style={{ backgroundColor:"#FFB261" }}
            className="navbar-brand col-sm-3 col-md-2 mr-0"
            href="https://twitter.com/DigitalPets1" // change to twitter address
            target="_blank"
            rel="noopener noreferrer"
          >

           <div className="text-white">Like Sim</div>

          
          </a>
              <a  style={{ backgroundColor:"#FFB261" }}
            className="navbar-brand col-sm-3 col-md-2 mr-0"
            href="https://twitter.com/DigitalPets1" // change to twitter address
            target="_blank"
            rel="noopener noreferrer"
          >

           <div className="text-white">Customize</div>

          
          </a>
         
              <a  style={{ backgroundColor:"#FFB261" }}
            className="navbar-brand col-sm-3 col-md-2 mr-0"
            href="https://twitter.com/DigitalPets1" // change to twitter address
            target="_blank"
            rel="noopener noreferrer"
          >

           <div className="text-white">Sim Market</div>

          
          </a>








          <ul className="navbar-nav px-3">
            <li className="nav-item text-nowrap d-none d-sm-none d-sm-block">
              <small  className="addresscolor"><span id="account"> {this.state.account}</span></small>
            </li>
          </ul>
        </nav>
        <div className="container-fluid mt-5">
          <div className="row">
            <main role="main" className="col-lg-10 d-flex text-center">
 



          <div  className="mr-3 ml-auto addresscolor container-fluid mt-5 ">

          <h5>Sim Name</h5>
      <h4>  </h4>
          <h5>Gender</h5>
    <h4></h4>
          <h5>Hair Color</h5>
   <h4></h4>
       <h5>Eye Color</h5>
     <h4></h4>
    <h5>Head Color</h5>
     

     
    </div>
    
    




              <div className="content mr-auto ">
             
                <form onSubmit={(event) => {
                  event.preventDefault()
                  const color = this.color.value
                 const secret = this.secret.value
                  const gender = this.gender.value
                  const haircolor = this.haircolor.value
                  
                    const eyecolor = this.eyecolor.value
                     const headcolor = this.headcolor.value
                  // const level = this.level.value
                  this.mint(color, gender, haircolor,eyecolor, headcolor,secret)
                }}>
                   <h4></h4>
                  <input
                    type='text'
                    className='form-control mb-1'
                     maxLength="20"
                    placeholder='example: jay Creator'
                    ref={(input) => {this.color = input}}
                  />
                 
                    <input
                    type='text'
                    className='form-control mb-1'
                    maxLength="20"
                    placeholder='male, female, alien'
                    ref={(planetin) => { this.gender = planetin }}
                  />
                  
                  <input
                    type='text'
                    className='form-control mb-1'
                     maxLength="10"
                    placeholder='red, green, black..'
                    ref={(haircolorin) => {this.haircolor = haircolorin}}
                  />
                  <input
                    type='text'
                    className='form-control mb-1'
                     maxLength="10"
                    placeholder='red, green, black..'
                    ref={(eyecolorin) => {this.eyecolor = eyecolorin}}
                  />

                  <input
                    type='text'
                    className='form-control mb-1'
                     maxLength="10"
                    placeholder='red, green, black..'
                    ref={(headcolorin) => {this.headcolor = headcolorin}}
                  />
                    <input
                    type='text'
                    className='form-control mb-1'
                     maxLength="250"
                    placeholder='Secret: add twitter, email, or info'
                    ref={(secretin) => {this.secret = secretin}}
                  />
                  <input
                    type='submit'
                    onClick={this.onClickCreateDialog}
                    style={{ backgroundColor:"#FFB261" }}
                    className='btn btn-block btn-primary '
                    value='Create Sim'
                  />
                   <Dialog ref={(el) => { this.dialog = el }} />
                </form>
              </div>




               


            </main>
          </div>
          <hr/>
          
               <h4 className="col-lg-10 d-flex text-center" className="text-white" style={{ backgroundColor:"#FFB261" }}   >
               All Crypto Sims</h4>
                <input
                    type='submit'
                    onClick={this.updateClick}
                    style={{ backgroundColor:"#FFB261" }}
                    className='btn btn-block btn-primary col-lg-1   '
                    value='Update'
                  />
             
          <div className="row text-center">

        

          
            { this.state.colors.map((color, key) => {

              return(

                <div key={key} className="col-md-4 mb-2">
                
                 <div className="token " style={{ backgroundImage: `url(${images[key]})` }}></div>
                <div text>Sim {key}</div>
                 <button disabled className="namebutton text-white"  >
                  
             <div>{color.name}</div>
        </button>
                  
              
                 
                 
                

                  <div>
                   <div data-tip data-for="registerTip">
                   <button  className="ownerbutton text-white" onClick={value => alert(`You can use this address to talk to this Crypto Sims: `+ "\n" + color.simowner)} >
             Owner
        </button>
      </div>

      
    </div>
      <div>
                   <div data-tip data-for="registersecret">
                   <button  className="ownerbutton text-white" onClick={value => alert( color.secret)}>
             Secret
        </button>
      </div>

      
    </div>

                
                </div>
              )
            })}

          </div>
        </div>

      </div>


    );


     

  }
}



export default App;
