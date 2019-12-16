Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030C31208A9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 15:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfLPObi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 09:31:38 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:55313 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728014AbfLPObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:31:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576506697; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=89aeAE4p0vIjzskvdLk1qVvaFpos+JuHN3FX5cvcZAc=;
 b=rUoB7/JPQv3lgx3+X5id/X494q4pamnnL7h5IEd6TqB2Qv8h7Y4jEHPP20JxPPmR4LQlBfBT
 r2CS+Ei6RSlKuyuGDdN/AZNVKY/7ZkcmFUQ/BaRHOsKXIUsS2Odoi6JkKzjBN0cWlEZHYZpa
 rXyenXClcV+jPY4E+lXj8gGabuQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df79544.7f5d70246bc8-smtp-out-n03;
 Mon, 16 Dec 2019 14:31:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62B76C433CB; Mon, 16 Dec 2019 14:31:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 333BDC43383;
        Mon, 16 Dec 2019 14:31:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Dec 2019 22:31:29 +0800
From:   cang@codeaurora.org
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] scsi: ufs: Put SCSI host after remove it
In-Reply-To: <85475247-efd5-732e-ae74-6d9a11e1bdf2@acm.org>
References: <1576328616-30404-1-git-send-email-cang@codeaurora.org>
 <1576328616-30404-2-git-send-email-cang@codeaurora.org>
 <85475247-efd5-732e-ae74-6d9a11e1bdf2@acm.org>
Message-ID: <cd6dc7c90d43b8ca8254a43da48334fc@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-15 02:32, Bart Van Assche wrote:
> On 12/14/19 8:03 AM, Can Guo wrote:
>> In ufshcd_remove(), after SCSI host is removed, put it once so that 
>> its
>> resources can be released.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> 
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index b5966fa..a86b0fd 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -8251,6 +8251,7 @@ void ufshcd_remove(struct ufs_hba *hba)
>>   	ufs_bsg_remove(hba);
>>   	ufs_sysfs_remove_nodes(hba->dev);
>>   	scsi_remove_host(hba->host);
>> +	scsi_host_put(hba->host);
>>   	/* disable interrupts */
>>   	ufshcd_disable_intr(hba, hba->intr_mask);
>>   	ufshcd_hba_stop(hba, true);
> 
> Hi Can,
> 
> The UFS driver may queue work asynchronously and that asynchronous
> work may refer to the SCSI host, e.g. ufshcd_err_handler(). Is it
> guaranteed that all that asynchronous work has finished before
> scsi_host_put() is called?
> 
> Thanks,
> 
> Bart.

Hi Bart,

As SCSI host is allocated in ufshcd_platform_init() during platform
drive probe, it is much more appropriate if platform driver calls
ufshcd_dealloc_host() in their own drv->remove() path. How do you
think if I change it as below? If it is OK to you, please ignore my
previous mails.

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 3d4582e..ea45756 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -3239,6 +3239,7 @@ static int ufs_qcom_remove(struct platform_device 
*pdev)

         pm_runtime_get_sync(&(pdev)->dev);
         ufshcd_remove(hba);
+       ufshcd_dealloc_host(hba);
         return 0;
  }

Thanks,

Can Guo.
