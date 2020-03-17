Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995911884AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgCQNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:04:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50220 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:04:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id z13so5302922wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CBpRlvxbCNLYQBl3LHSl0nng0Xdghb8tGGZtN/n8eEA=;
        b=rs3av+teL5zRUCvHPgx0S8WLpLFXi/rQjT3qB12O1odsCNVyHCow3jyqCTVPz/axhJ
         eTsPQ2FFB3XvyuO18IXsMrg1ZOKShEWYZ2sfwrkKe1/rEBeGMZlvmRmzO00qhR4zj6Lt
         CxVsedfjrja6Vj3mpnk+WzAJqZuf8eCOW5m1bsFBkjmhqYzQ8zcyPdu/0ntu6Gny4Y3b
         vkOYP9nfl+GvFLhGlF6PcTf9LLl3ttKODvTDp0s0Tq2/RtxVr1iM/veBe4d3iehiiz+/
         j3x4gbNocMZa2mhfNmKBJA6UuF+j0Yfg5Udrl7kPcL90VORPO9nqpXNuC3dYaSeQHR3e
         NdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBpRlvxbCNLYQBl3LHSl0nng0Xdghb8tGGZtN/n8eEA=;
        b=rMb6h1gLnBy2P3dERxX6N7rvHwIa9Cw0+wzzk2VIXc60Bz+Pndw1G2HkUh+tUCvfXP
         1Hbr4sqUO+0o6gdqvgknmKPQ1HloIJab7+TznI65z07HRWfIxripz3OsQHJ00O4yZmbB
         Km8kWv6ySsQ31YW7sVSDIp1IjOUMpSC/FjBYp1bZQ8TQ+BT5RE8Ut+XtP1IdiQulNsyY
         n1Q3Opup141Ac8aCfYBdiau1p/QP9/VWsls5ENcFigs3vd1TMj6h/L77IkzBXwBF2Jnj
         HQZKvO9eRY0RCX7IopJ0MNOfzP9DyewaZvHkH7oO3YkcnpBg5XdfyR895tozDsHS0kO0
         vU6A==
X-Gm-Message-State: ANhLgQ1c6EYgEV8jooGxZQHwjM2ZyfozApKE9sVrK/vsk7Cly9hMc6ls
        AwPzE3v+MrdMD6a2Lkpo5pi4Zg==
X-Google-Smtp-Source: ADFU+vvoAkMzfYgPtp1cZbiMZaoUYcRqXKDAwxi7Sx36tQoZJ/ASy2GDlCOByqHGITcuN6yxlu3RcQ==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr5170207wmc.53.1584450264035;
        Tue, 17 Mar 2020 06:04:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a13sm4566335wrh.80.2020.03.17.06.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 06:04:18 -0700 (PDT)
Subject: Re: [PATCH] soundwire: stream: only change state if needed
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
 <6bc8412a-f6d9-64d1-2218-ca98cfdb31c0@linaro.org>
 <27a73cbd-9418-4488-5cb2-fb21f9fc9110@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c1e5dc89-a069-a427-4912-89d90ecc0334@linaro.org>
Date:   Tue, 17 Mar 2020 13:04:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <27a73cbd-9418-4488-5cb2-fb21f9fc9110@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2020 12:22, Pierre-Louis Bossart wrote:
> 
> The change below would be an error case for Intel, so it's probably 
> better if we go with your suggestion. You have a very specific state 
> handling due to your power amps and it's probably better to keep it 
> platform-specific.

Just trying to understand, why would it be error for Intel case?

IMO, If stream state is SDW_STREAM_ENABLED that also implicit that its 
prepared too. Similar thing with SDW_STREAM_DEPREPARED.
Isn't it?

--srini


