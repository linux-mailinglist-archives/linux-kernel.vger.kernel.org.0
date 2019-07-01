Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5E24FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfEUNP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 09:15:28 -0400
Received: from verein.lst.de ([213.95.11.211]:60305 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfEUNP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:15:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4C85168AFE; Tue, 21 May 2019 15:15:04 +0200 (CEST)
Date:   Tue, 21 May 2019 15:15:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: truncate dma masks to what dma_addr_t
 can hold
Message-ID: <20190521131503.GA5258@lst.de>
References: <20190521124729.23559-1-hch@lst.de> <20190521124729.23559-2-hch@lst.de> <20190521130436.bgt53bf7nshz62ip@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521130436.bgt53bf7nshz62ip@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:04:37PM +0100, Russell King - ARM Linux admin wrote:
> So how does the driver negotiation for >32bit addresses work if we don't
> fail for large masks?
> 
> I'm thinking about all those PCI drivers that need DAC cycles for >32bit
> addresses, such as e1000, which negotiate via (eg):
> 
>         /* there is a workaround being applied below that limits
>          * 64-bit DMA addresses to 64-bit hardware.  There are some
>          * 32-bit adapters that Tx hang when given 64-bit DMA addresses
>          */
>         pci_using_dac = 0;
>         if ((hw->bus_type == e1000_bus_type_pcix) &&
>             !dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
>                 pci_using_dac = 1;
>         } else {
>                 err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>                 if (err) {
>                         pr_err("No usable DMA config, aborting\n");
>                         goto err_dma;
>                 }
>         }
> 
> and similar.  If we blindly trunate the 64-bit to 32-bit, aren't we
> going to end up with PCI cards using DAC cycles to a host bridge that
> do not support DAC cycles?

In general PCI devices just use DAC cycles when they need it.  I only
know of about a handful of devices that need to negotiate their
addressing mode, and those already use the proper API for that, which
is dma_get_required_mask.

The e1000 example is a good case of how the old API confused people.
First it only sets the 64-bit mask for devices which can support it,
which is good, but then it sets the NETIF_F_HIGHDMA flag only if we
set a 64-bit mask, which is completely unrelated to the DMA mask,
it just means the driver can handle sk_buff fragments that do not
have a kernel mapping, which really is a driver and not a hardware
issue.

So what this driver really should do is something like:


diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 551de8c2fef2..d9236083da94 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -925,7 +925,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	static int cards_found;
 	static int global_quad_port_a; /* global ksp3 port a indication */
-	int i, err, pci_using_dac;
+	int i, err;
 	u16 eeprom_data = 0;
 	u16 tmp = 0;
 	u16 eeprom_apme_mask = E1000_EEPROM_APME;
@@ -996,16 +996,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * 64-bit DMA addresses to 64-bit hardware.  There are some
 	 * 32-bit adapters that Tx hang when given 64-bit DMA addresses
 	 */
-	pci_using_dac = 0;
-	if ((hw->bus_type == e1000_bus_type_pcix) &&
-	    !dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
-		pci_using_dac = 1;
-	} else {
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			pr_err("No usable DMA config, aborting\n");
-			goto err_dma;
-		}
+	err = dma_set_mask_and_coherent(&pdev->dev,
+		DMA_BIT_MASK(hw->bus_type == e1000_bus_type_pcix ? 64 : 32));
+	if (err) {
+		pr_err("No usable DMA config, aborting\n");
+		goto err_dma;
 	}
 
 	netdev->netdev_ops = &e1000_netdev_ops;
@@ -1047,19 +1042,15 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 
-	netdev->features |= netdev->hw_features;
+	netdev->features |= netdev->hw_features | NETIF_F_HIGHDMA;
 	netdev->hw_features |= (NETIF_F_RXCSUM |
 				NETIF_F_RXALL |
 				NETIF_F_RXFCS);
 
-	if (pci_using_dac) {
-		netdev->features |= NETIF_F_HIGHDMA;
-		netdev->vlan_features |= NETIF_F_HIGHDMA;
-	}
-
 	netdev->vlan_features |= (NETIF_F_TSO |
 				  NETIF_F_HW_CSUM |
-				  NETIF_F_SG);
+				  NETIF_F_SG |
+				  NETIF_F_HIGHDMA);
 
 	/* Do not set IFF_UNICAST_FLT for VMWare's 82545EM */
 	if (hw->device_id != E1000_DEV_ID_82545EM_COPPER ||

