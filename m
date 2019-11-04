Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58398EF156
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 00:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbfKDXoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 18:44:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfKDXoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:44:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B5EA860E07; Mon,  4 Nov 2019 23:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572911056;
        bh=EYW8abyE8lJm8s9y7qGJ4MoU1MjvPiVlESI93EIvGVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o05vGWKJ4TCep6Hn7jc9yhOW3zkUofrWiCjvTUcUexx/SXDmpfODQbGvliSV3Cglr
         m096Ah5thZPeSnkvvGAIXhlmDS+G53owwjwHrysxhWf+yRzvXbccMPoY9vNDtB913f
         5GaxfigMEEOUTFIzvB+4Kitc4nw38w5FS1wfFTxc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3080C60D7C;
        Mon,  4 Nov 2019 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572911055;
        bh=EYW8abyE8lJm8s9y7qGJ4MoU1MjvPiVlESI93EIvGVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eRCQEVHm6BTWoZ77VL8qmiH4MrC7Jd/x1nU1V9JFv8tF6nQINUNK6ClHVFLatr+W2
         MCTqRoSF9h7iTmfEKaZr5vHPrnybElrH88gHsqU9iAkWh8R9s7wYJx/EnL5mWGcZ7A
         0i/elXwCqxjPfRh5fHzHCqIWP45auqrZEIFKCdu8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Nov 2019 07:44:13 +0800
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
        Tomas Winkler <tomas.winkler@intel.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] scsi: ufs: Introduce a vops for resetting host
 controller
In-Reply-To: <MN2PR04MB69911784473463D0926AE3B5FC7F0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <1571804009-29787-1-git-send-email-cang@codeaurora.org>
 <1571804009-29787-2-git-send-email-cang@codeaurora.org>
 <MN2PR04MB69911784473463D0926AE3B5FC7F0@MN2PR04MB6991.namprd04.prod.outlook.com>
Message-ID: <1ab0a928184dd11540726d6456056e02@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-04 22:28, Avri Altman wrote:
> Hi,
>> 
>> Some UFS host controllers need their specific implementations of 
>> resetting to
>> get them into a good state. Provide a new vops to allow the platform 
>> driver to
>> implement this own reset operation.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
> Did you withdraw from this patches and insert them to one of your fix 
> bundle?
> I couldn't tell.
> As this is a vop, in what way its functionality can't be included in
> the device reset that was recently added?
> 
> Thanks,
> Avri

Hi Avri,

Sorry for making you confused.
Yes, I dropped this series because it cannot fulfil its purpose anymore. 
I come up with a way which puts the reset in the right place in UFS QCOM 
platfrom driver without an extra vops, so I inserted the two changes in 
fix bundle 3.

Thanks,
Can Guo.

