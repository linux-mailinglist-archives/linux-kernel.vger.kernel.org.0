Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEDBA8833
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfIDOBa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Sep 2019 10:01:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57388 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731161AbfIDOB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:01:29 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id C7B46CECA3;
        Wed,  4 Sep 2019 16:10:14 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: btrtl: Fix an issue that failing to download
 the FW which size is over 32K bytes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190902090809.3409-1-max.chou@realtek.com>
Date:   Wed, 4 Sep 2019 16:01:26 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn
Content-Transfer-Encoding: 8BIT
Message-Id: <4BACAECC-C4CF-4EB7-8626-E628934DAE32@holtmann.org>
References: <20190902090809.3409-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

> Fix the issue that when the FW size is 32K+, it will fail for the download
> process because of the incorrect index.
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> drivers/bluetooth/btrtl.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 0354e93e7a7c..215896af0259 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -389,6 +389,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
> 	int frag_len = RTL_FRAG_LEN;
> 	int ret = 0;
> 	int i;
> +	int j;
> 	struct sk_buff *skb;
> 	struct hci_rp_read_local_version *rp;
> 
> @@ -401,7 +402,12 @@ static int rtl_download_firmware(struct hci_dev *hdev,
> 
> 		BT_DBG("download fw (%d/%d)", i, frag_num);
> 
> -		dl_cmd->index = i;
> +		if (i > 0x7f)
> +			j = (i & 0x7f) + 1;
> +		else
> +			j = i;
> +
> +		dl_cmd->index = j;

so this seems rather complicated with the extra variable.

		if (i > 0x7f)
			dl_cmd->index = (i & 0x7f) + 1;
		else
			dl_cmd->index = i;

And I would prefer to have a small comment above on why this is done this way.

Regards

Marcel

