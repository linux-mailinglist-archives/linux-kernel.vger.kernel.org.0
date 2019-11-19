Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBF610180C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 07:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfKSFfx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Nov 2019 00:35:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55610 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfKSFfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:35:51 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 33E83CECED;
        Tue, 19 Nov 2019 06:44:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v6 2/4] Bluetooth: btbcm: Support pcm configuration
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191118110335.v6.2.I2a9640407d375f20c7c8f4afd1607db143ff0246@changeid>
Date:   Tue, 19 Nov 2019 06:35:49 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <989EE002-F3F4-441B-BD9B-B460D8B09708@holtmann.org>
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
 <20191118110335.v6.2.I2a9640407d375f20c7c8f4afd1607db143ff0246@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> Add BCM vendor specific command to configure PCM parameters. The new
> vendor opcode allows us to set the sco routing, the pcm interface rate,
> and a few other pcm specific options (frame sync, sync mode, and clock
> mode). See broadcom-bluetooth.txt in Documentation for more information
> about valid values for those settings.
> 
> Here is an example trace where this opcode was used to configure
> a BCM4354:
> 
>        < HCI Command: Vendor (0x3f|0x001c) plen 5
>                01 02 00 01 01
>> HCI Event: Command Complete (0x0e) plen 4
>        Vendor (0x3f|0x001c) ncmd 1
>                Status: Success (0x00)
> 
> We can read back the values as well with ocf 0x001d to confirm the
> values that were set:
>        $ hcitool cmd 0x3f 0x001d
>        < HCI Command: ogf 0x3f, ocf 0x001d, plen 0
>> HCI Event: 0x0e plen 9
>        01 1D FC 00 01 02 00 01 01
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
> drivers/bluetooth/btbcm.c | 47 +++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btbcm.h | 16 +++++++++++++
> 2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 2d2e6d862068..df90841d29c5 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -105,6 +105,53 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> }
> EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
> 
> +int btbcm_read_pcm_int_params(struct hci_dev *hdev,
> +			      struct bcm_set_pcm_int_params *int_params)
> +{

the name should be _param and not _params since if I remember correctly that is how Broadcom specified it. Also just use param as variable name.

> +	struct sk_buff *skb;
> +	int err = 0;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc1d, 5, int_params, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "BCM: Read PCM int params failed (%d)", err);
> +		return err;
> +	}
> +
> +	if (!skb->data[0] && skb->len == sizeof(*int_params) + 1) {
> +		memcpy(int_params, &skb->data[1], sizeof(*int_params));
> +	} else {
> +		bt_dev_err(hdev,
> +			   "BCM: Read PCM int params failed (%d), Length (%d)",
> +			   skb->data[0], skb->len);
> +		err = -EINVAL;
> +	}
> +
> +	kfree_skb(skb);

I find these harder to read actually and it can be still fault at data[0] access.

	if (skb->len != sizeof(*param) || skb->data[0]) {
		bt_dev_err(hdev, "BCM: Read SCO PCM int parameter failure");    
		kfree_skb(skb);                                                  
		return -EIO;
	}

	memcpy(param, skb->data + 1, sizeof(*param));
	kfree_skb(skb);
	return 0;
}
	
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(btbcm_read_pcm_int_params);
> +
> +int btbcm_write_pcm_int_params(struct hci_dev *hdev,
> +			       const struct bcm_set_pcm_int_params *int_params)
> +{
> +	struct sk_buff *skb;
> +	int err;
> +
> +	/* Vendor ocf 0x001c sets the pcm parameters and 0x001d reads it */

Scrap this comment.

> +	skb = __hci_cmd_sync(hdev, 0xfc1c, 5, int_params, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "BCM: Write PCM int params failed (%d)", err);
> +		return err;
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btbcm_write_pcm_int_params);
> +
> int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
> {

Otherwise this looks good.

Regards

Marcel

