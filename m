Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2734F1008E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 17:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKRQHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 11:07:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54100 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfKRQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:07:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIFsVX9082261;
        Mon, 18 Nov 2019 16:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=5LrZNngyoVfCx88Bvpw1mdp8Hhz6i8TqkHxPrhE64AI=;
 b=aoJuuGTdSskvA9K3RIgRdfR2Sc/czN1+Q7j3Uv38/WBrrOYxN5n1X68XSoJwERLD+bif
 wl8mLs0+ayAOXIjkGRyyggfydR9BoKJcr1doU/2ZQ2UXWWLdiEzwjPTljibs7GTNP77C
 QMp04ldDnJJpde/xd0XbDH8RQ/QagSnsPu4jF5FZVW8EW+8K42ujVmV8GC2rUOhhfmng
 FaV76r/6K1tERyNNhwX5PNea/0z3rGf//I0doUnPLj0jR9RCJaOikmHvFtHPMMXqEqS8
 T9jlc2eO9smGShhZea7+uNoM343m5StKvrnX9Id9TlE9TxwAy2KINwdZ04YIXU+5g8tH Cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wa92ph4fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 16:05:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIFsKIh018028;
        Mon, 18 Nov 2019 16:05:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wau8ng3y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 16:05:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAIG4QFv027222;
        Mon, 18 Nov 2019 16:04:26 GMT
Received: from kadam (/41.210.146.114)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 08:04:25 -0800
Date:   Mon, 18 Nov 2019 19:04:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        Akshu.Agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] ASoC: amd:Create multiple I2S platform device
 endpoint
Message-ID: <20191118160231.GA5626@kadam>
References: <1574085861-22818-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574085861-22818-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574085861-22818-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=852
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=921 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 07:34:16PM +0530, Ravulapati Vishnu vardhan rao wrote:
>  static int snd_acp3x_probe(struct pci_dev *pci,
>  			   const struct pci_device_id *pci_id)
>  {
> -	int ret;
> -	u32 addr, val;
>  	struct acp3x_dev_data *adata;
> -	struct platform_device_info pdevinfo;
> +	struct platform_device_info pdevinfo[ACP3x_DEVS];
>  	unsigned int irqflags;
> +	int ret, val, i;
> +	u32 addr;
>  
>  	if (pci_enable_device(pci)) {
>  		dev_err(&pci->dev, "pci_enable_device failed\n");
> @@ -40,10 +40,10 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  	}
>  
>  	adata = devm_kzalloc(&pci->dev, sizeof(struct acp3x_dev_data),
> -			     GFP_KERNEL);
> +							     GFP_KERNEL);
>  	if (!adata) {
>  		ret = -ENOMEM;
> -		goto release_regions;
> +		goto adata_free;
>  	}
>  
>  	/* check for msi interrupt support */
> @@ -56,7 +56,8 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  		irqflags = 0;
>  
>  	addr = pci_resource_start(pci, 0);
> -	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
> +	adata->acp3x_base = devm_ioremap(&pci->dev, addr,
> +					pci_resource_len(pci, 0));
>  	if (!adata->acp3x_base) {
>  		ret = -ENOMEM;
>  		goto release_regions;
> @@ -68,11 +69,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  	switch (val) {
>  	case I2S_MODE:
>  		adata->res = devm_kzalloc(&pci->dev,
> -					  sizeof(struct resource) * 2,
> +					  sizeof(struct resource) * 4,
>  					  GFP_KERNEL);
>  		if (!adata->res) {
>  			ret = -ENOMEM;
> -			goto unmap_mmio;
> +			goto release_regions;
>  		}
>  
>  		adata->res[0].name = "acp3x_i2s_iomem";
> @@ -80,28 +81,52 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  		adata->res[0].start = addr;
>  		adata->res[0].end = addr + (ACP3x_REG_END - ACP3x_REG_START);
>  
> -		adata->res[1].name = "acp3x_i2s_irq";
> -		adata->res[1].flags = IORESOURCE_IRQ;
> -		adata->res[1].start = pci->irq;
> -		adata->res[1].end = pci->irq;
> +		adata->res[1].name = "acp3x_i2s_sp";
> +		adata->res[1].flags = IORESOURCE_MEM;
> +		adata->res[1].start = addr + ACP3x_I2STDM_REG_START;
> +		adata->res[1].end = addr + ACP3x_I2STDM_REG_END;
> +
> +		adata->res[2].name = "acp3x_i2s_bt";
> +		adata->res[2].flags = IORESOURCE_MEM;
> +		adata->res[2].start = addr + ACP3x_BT_TDM_REG_START;
> +		adata->res[2].end = addr + ACP3x_BT_TDM_REG_END;
> +
> +		adata->res[3].name = "acp3x_i2s_irq";
> +		adata->res[3].flags = IORESOURCE_IRQ;
> +		adata->res[3].start = pci->irq;
> +		adata->res[3].end = adata->res[3].start;
>  
>  		adata->acp3x_audio_mode = ACP3x_I2S_MODE;
>  
>  		memset(&pdevinfo, 0, sizeof(pdevinfo));
> -		pdevinfo.name = "acp3x_rv_i2s";
> -		pdevinfo.id = 0;
> -		pdevinfo.parent = &pci->dev;
> -		pdevinfo.num_res = 2;
> -		pdevinfo.res = adata->res;
> -		pdevinfo.data = &irqflags;
> -		pdevinfo.size_data = sizeof(irqflags);
> -
> -		adata->pdev = platform_device_register_full(&pdevinfo);
> -		if (IS_ERR(adata->pdev)) {
> -			dev_err(&pci->dev, "cannot register %s device\n",
> -				pdevinfo.name);
> -			ret = PTR_ERR(adata->pdev);
> -			goto unmap_mmio;
> +		pdevinfo[0].name = "acp3x_rv_i2s_dma";
> +		pdevinfo[0].id = 0;
> +		pdevinfo[0].parent = &pci->dev;
> +		pdevinfo[0].num_res = 4;
> +		pdevinfo[0].res = &adata->res[0];
> +		pdevinfo[0].data = &irqflags;
> +		pdevinfo[0].size_data = sizeof(irqflags);
> +
> +		pdevinfo[1].name = "acp3x_i2s_playcap";
> +		pdevinfo[1].id = 0;
> +		pdevinfo[1].parent = &pci->dev;
> +		pdevinfo[1].num_res = 1;
> +		pdevinfo[1].res = &adata->res[1];
> +
> +		pdevinfo[2].name = "acp3x_i2s_playcap";
> +		pdevinfo[2].id = 1;
> +		pdevinfo[2].parent = &pci->dev;
> +		pdevinfo[2].num_res = 1;
> +		pdevinfo[2].res = &adata->res[2];
> +		for (i = 0; i < ACP3x_DEVS ; i++) {
> +			adata->pdev[i] =
> +				platform_device_register_full(&pdevinfo[i]);
> +			if (IS_ERR(adata->pdev[i])) {
> +				dev_err(&pci->dev, "cannot register %s device\n",
> +					pdevinfo[i].name);
> +				ret = PTR_ERR(adata->pdev[i]);
> +				goto unmap_mmio;
> +			}
>  		}
>  		break;
>  	default:
> @@ -112,10 +137,22 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  	return 0;
>  
>  unmap_mmio:
> +	if (val == I2S_MODE)
> +		for (i = 0 ; i < ACP3x_DEVS ; i++)
> +			platform_device_unregister(adata->pdev[i]);

I really wish you had done this the way, I said.  That's the easiest
way to audit.  Otherwise you have to check that adata->pdev[] is
initialized and that platform_device_unregister() accepts both error
pointers and NULLs.  It does.  But it's easier to audit if you only
free things which have been allocated and never free things which were
not allocated.

> +	devm_kfree(&pci->dev, adata->res);

Don't free devm_ allocated data.  It gets freed for you automatically.

> +	devm_kfree(&pci->dev, adata);
>  	pci_disable_msi(pci);
> -	iounmap(adata->acp3x_base);
> +	pci_release_regions(pci);
> +	pci_disable_device(pci);
>  release_regions:
> +	devm_kfree(&pci->dev, adata);
> +	pci_disable_msi(pci);

This disables the msi twice so it's a double free situation.  It would
have been better to just cut and paste the code that I wrote for you.

regards,
dan carpenter

