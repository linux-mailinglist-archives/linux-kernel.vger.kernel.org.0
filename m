Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B5128EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLVQ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 11:26:53 -0500
Received: from node.akkea.ca ([192.155.83.177]:36884 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfLVQ0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 11:26:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 5997E4E2006;
        Sun, 22 Dec 2019 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1577032012; bh=lk9n/H5OSRh/eNco0XIFOxKBT6v9JzTnq1Z23DQmHEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=tAU8nMI+A66/QdQwZA2pwNdrzATWia4EeolinMMU1jAcyZL+fglcCS3oUTOFy+ThO
         BGUxVDCD4QE3O5/vd3sDUj5mNF02iipVrkvGsT87SqV/G8oNmONgVtvh7ye/sGR8Nu
         gEt3+0Ji/GvnlH5411c40PApaFQoL3h86FH5ujiM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c0Ju1VJTmglr; Sun, 22 Dec 2019 16:26:51 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id C44C94E2003;
        Sun, 22 Dec 2019 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1577032011; bh=lk9n/H5OSRh/eNco0XIFOxKBT6v9JzTnq1Z23DQmHEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=QgPaewRv2sRM8fKVBqjqVQMZPUjRwmFsgBADtmiybFwygb8QbDiI/kUQWSWvB/XZA
         cIRz2yK0Dvi14pAikoDCg2Ce3M32fPvZ2cij7clvJ2AEbU+sl/EnPVxGiO+PHIiCSV
         0qhPvkRdE2TJ7NYLfESfcIno9oy1y7X0YnDBUWYc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 22 Dec 2019 08:26:51 -0800
From:   Angus Ainslie <angus@akkea.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ASoC: gtm601: add Broadmobi bm818 sound profile
In-Reply-To: <20191220130143.GF4790@sirena.org.uk>
References: <20191219210944.18256-1-angus@akkea.ca>
 <20191219210944.18256-2-angus@akkea.ca>
 <20191220130143.GF4790@sirena.org.uk>
Message-ID: <499dffad51cb7819bd118ad15048816c@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-20 05:01, Mark Brown wrote:
> On Thu, Dec 19, 2019 at 01:09:43PM -0800, Angus Ainslie (Purism) wrote:
> 
>>  static int gtm601_platform_probe(struct platform_device *pdev)
>>  {
>> +	struct snd_soc_dai_driver *dai_driver;
>> +
>> +	dai_driver = of_device_get_match_data(&pdev->dev);
>> +
> 
> I was going to apply this but it causes build warnings:
> 
> sound/soc/codecs/gtm601.c: In function ‘gtm601_platform_probe’:
> sound/soc/codecs/gtm601.c:83:13: warning: assignment discards ‘const’
> qualifier from pointer target type [-Wdiscarded-qualifiers]
>   dai_driver = of_device_get_match_data(&pdev->dev);
>              ^

Sorry, missed that.

New version inbound.

Angus
