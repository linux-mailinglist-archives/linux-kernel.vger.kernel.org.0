Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33BA291CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 07:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfHSFuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 01:50:24 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:57382 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfHSFuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:50:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 055B56A0;
        Mon, 19 Aug 2019 07:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1566193817; x=1568008218; bh=xu4Q1p4bYiyi178072Bu6oked5lCfvizVFr
        3BFHAwcg=; b=WtRL/ltslL/Fnt2ZxIqmGprzvVhqLqJ7SR3Y0LzCdfjST699SS8
        8gxx6tV4fFXAJe2O5APZceuxcQQH6iywuJMCbSUxB/LaDyZ4smWmHflo018XrYMM
        9ccarFDKrqfhBDpsNZ1RA0budyGEyIbbcFVJYcOcH0sWBqnBM0N314eNem6WKTOa
        baSsjqtIBVrqTwem0y3Fhib1RXqunEJkREyp69IEpJu3hzYa2KmPdf0uX7uLWAB4
        TO5UsLjDEF0xZ8tzAiMj0uRks/PNpMgRIrmjA3XNanJCQzAkzhdc5HvhxreL5zc2
        VCxunJwyv9mT7oqcG30RkUGL7OrRmKOvGORjfFLKswp8g/eFithHhBTKgD9mtmkt
        WSc6qJVUzVdV9Grd2kpK/twyr8iyQdZWGTW0hJO+Yw9XS+0vfJjpC45OdAnDih+z
        vNzMJ9XrQriuoLsJZ0z5Sj/NPY8iNSylSAWIeNG01p/WTYznpUW0fuQDnEPWPhwY
        ds+xNuyJ3jafNiejMA5p6VU7Rfji33tekucD8vDnWdTAimCm0LQZu2q+NF58IRf0
        WIScSCdjalouTOmldZY/fP4BM58JXBd7eR9chkps9RVG+9yyVYMkA1Wezc6Ahytn
        +JCsckAABWzBT5z2h2d4JzvhJdOZGEf36gBrKR5WtljnCgZ1jflG/fF8=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id an7HK7bIczcE; Mon, 19 Aug 2019 07:50:17 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 99A39185;
        Mon, 19 Aug 2019 07:50:17 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 348128D69;
        Mon, 19 Aug 2019 07:50:17 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jacob Huisman <jacobhuisman@kernelthusiast.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: fix broken link
Date:   Mon, 19 Aug 2019 07:50:15 +0200
Message-ID: <3592371.DDP23MczKt@pcbe13614>
In-Reply-To: <20190816122209.5bz4rlln5cahn7ki@jacob-MS-7A62>
References: <20190816122209.5bz4rlln5cahn7ki@jacob-MS-7A62>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 16, 2019 2:22:09 PM CEST Jacob Huisman wrote:
> http://linux.yyz.us/patch-format.html seems to be down since
> approximately September 2018. There is a working archive copy on
> arhive.org. Replaced the links in documenation + translations.
> 
> Signed-off-by: Jacob Huisman <jacobhuisman@kernelthusiast.com>

Reviewed-by: Federico Vaga <federico.vaga@vaga.pv.it>


