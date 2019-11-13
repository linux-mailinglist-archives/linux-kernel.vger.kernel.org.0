Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D07F9F65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 01:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKMAlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 19:41:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54652 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMAlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:41:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6DCBC6078A; Wed, 13 Nov 2019 00:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573605684;
        bh=uZiyTjnsg/7XCS4wXeu1iYBMRRvJ4sByw11TaeFLRYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pFBDnjapNW1rNrLbo6CJVvdLUiEqBCzv8OiCVfGqcVWNrTaRNi2WleTy89s/SwUxx
         xWzXZLbrO1m4/w7Cnx7JxLD2DTaZ8E2cKJY/HCaUtJ3PgqJur65qwnaY29xfu3H1Fj
         lQ790hPGBR54n1A7vvpIhACQgK0bjnI7Fkq3I3YM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8586D60117;
        Wed, 13 Nov 2019 00:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573605683;
        bh=uZiyTjnsg/7XCS4wXeu1iYBMRRvJ4sByw11TaeFLRYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FL+JwYGfit755UkRwchX/hZ3S7lPOFsMAyT3n0+1aGILby8txG5ewyzn4SA/lrjt9
         aKYCdDa0QvNd2Pe7HOly+TS9wkFXCbRqoMX1b5Dg6tmzuvWUK8AWOtzMtSFHXGJnpT
         Q9bDNhYxFVR8PN9NXjeHRWtoDbBaDrXe06gY2QBc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 08:41:23 +0800
From:   cang@codeaurora.org
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] scsi: ufs: Add new bit field PA_INIT to UECDL
 register
In-Reply-To: <MN2PR04MB69910D7CB55980F2C498A468FC770@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <1573200932-384-1-git-send-email-cang@codeaurora.org>
 <1573200932-384-3-git-send-email-cang@codeaurora.org>
 <MN2PR04MB69910D7CB55980F2C498A468FC770@MN2PR04MB6991.namprd04.prod.outlook.com>
Message-ID: <1ca07e76a0b6c95a116c44c4115508d4@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-12 15:53, Avri Altman wrote:
>> 
>> Add new bit field (bit-15) PA_INIT to UECDL register, this will 
>> correctly handle
>> any PA_INIT error.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
> Acked-by Avri Altman <avri.altman@wdc.com>
> 
> This is a HCI3.0 change, so maybe make note of that?
> But UIC_DATA_LINK_LAYER_ERROR_CODE_MASK isn't being used anywhere,
> better just remove it, don't you think?
> Instead, while at it, fix ufshcd_update_uic_error to check
> UIC_DATA_LINK_LAYER_ERROR when checking for data link layer errors?

Hi Avri,

I will squash this change to my patch, it is used there.
[PATCH v3 5/7] scsi: ufs: Fix irq return code
url - https://lore.kernel.org/patchwork/patch/1148656/

Thanks,
Can Guo.
