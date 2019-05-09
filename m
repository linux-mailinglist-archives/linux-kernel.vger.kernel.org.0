Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CE818323
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 03:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEIBJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 21:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfEIBJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:09:43 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F606214AF;
        Thu,  9 May 2019 01:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557364182;
        bh=a0Fe5iOq9yzYPB9phD7q6sNgTD0wMUOBXAkPMDa6OKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmbTsB9zmMA2lVN4aLELutZP8sm8eZbR74fGwDtUcpF7lHe8mFm8sNaSlf5QYzCAE
         xT2gE18I1auYIrqQsa882Aifj21EAzWJVHnMYXFcbvBst6MNWocM9SJIlt/MKB2VTw
         EYcm1wMWHhlRUwyKdjGFyTo7nvHw9H5kvytIiC/U=
Date:   Wed, 8 May 2019 21:09:41 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Adrian Vladu <avladu@cloudbasesolutions.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: Re: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
 lsvmbus
Message-ID: <20190509010941.GT1747@sasha-vm>
References: <20190506172737.18122-1-avladu@cloudbasesolutions.com>
 <20190506173331.18906-1-avladu@cloudbasesolutions.com>
 <PU1P153MB016957AD2B1C356FA1BFB1A8BF310@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB016957AD2B1C356FA1BFB1A8BF310@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 05:02:47AM +0000, Dexuan Cui wrote:
>> From: Adrian Vladu <avladu@cloudbasesolutions.com>
>> Sent: Monday, May 6, 2019 10:34 AM
>> To: linux-kernel@vger.kernel.org
>> Cc: Adrian Vladu <avladu@cloudbasesolutions.com>; KY Srinivasan
>> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
>> Hemminger <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>;
>> Dexuan Cui <decui@microsoft.com>; Alessandro Pilotti
>> <apilotti@cloudbasesolutions.com>
>> Subject: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for lsvmbus
>>
>> Fixed pep8/flake8 python style code for lsvmbus tool.
>>
>> The TAB indentation was on purpose ignored (pep8 rule W191) to make
>> sure the code is complying with the Linux code guideline.
>> The following command do not show any warnings now:
>> pep8 --ignore=W191 lsvmbus
>> flake8 --ignore=W191 lsvmbus
>>
>> Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>
>>
>> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Stephen Hemminger <sthemmin@microsoft.com>
>> Cc: Sasha Levin <sashal@kernel.org>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
[...]
>Looks good to me. Thanks, Adrian!
>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>

Queued for hyperv-fixes, thanks!

--
Thanks,
Sasha
