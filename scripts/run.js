const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
  
    console.log('Contract deployed to:', waveContract.address);
    console.log('Contract deployed by:', owner.address);
  
    // wave
    let waveCount;
    waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave(0, "wave message 1");
    await waveTxn.wait();
  
    waveCount = await waveContract.getTotalWaves();
    console.log("waveCount -->", waveCount);
    
    waves = await waveContract.getAllWaves();
    console.log("waves -->", waves);
    
    waveTxn = await waveContract.connect(randomPerson).wave(1, "hang loose message 1");
    await waveTxn.wait();
    waveTxn = await waveContract.connect(randomPerson).wave(1, "hang loose message 2");
    await waveTxn.wait();
    
    waveCount = await waveContract.getTotalHangLooses();
    console.log("hangLooseCount -->", waveCount);

    waves = await waveContract.getAllWaves();
    console.log("waves -->", waves);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();