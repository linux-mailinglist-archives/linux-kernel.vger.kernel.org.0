Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19429A5CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfIBTTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 15:19:34 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:51571 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfIBTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:19:33 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x82JJAia011666;
        Tue, 3 Sep 2019 04:19:11 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Tue, 03 Sep 2019 04:19:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x82JJAlm011657
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 3 Sep 2019 04:19:10 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v2 1/3] ASoC: es8316: judge PCM rate at later timing
To:     Mark Brown <broonie@kernel.org>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190831162650.19822-1-katsuhiro@katsuster.net>
 <20190902120248.GA5819@sirena.co.uk>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <1a3c5934-4731-d474-e9d5-795e8337b180@katsuster.net>
Date:   Tue, 3 Sep 2019 04:19:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902120248.GA5819@sirena.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thanks a lot for your comments.

On 2019/09/02 21:02, Mark Brown wrote:
> On Sun, Sep 01, 2019 at 01:26:48AM +0900, Katsuhiro Suzuki wrote:
>> This patch change the judge timing about playing/capturing PCM rate.
>>
>> Original code set constraints list of PCM rate limits at set_sysclk.
>> This strategy works well if system is using fixed rate clock.
>>
>> But some boards and SoC (such as RockPro64 and RockChip I2S) has
>> connected SoC MCLK out to ES8316 MCLK in. In this case, SoC side I2S
>> will choose suitable frequency of MCLK such as fs * mclk-fs when
>> user starts playing or capturing.
> 
> The best way to handle this is to try to support both fixed and variable
> clock rates, some other drivers do this by setting constraints based on
> MCLK only if the MCLK has been set to a non-zero value.  They have the
> machine drivers reset the clock rate to 0 when it goes idle so that no
> constraints are applied then.  This means that if the machine has a
> fixed clock there will be constraints, and that constraints get applied
> if one direction has started and fixed the clock, but still allows the
> clock to be varied where possible.
> 

In my understanding, fixed and variable clock both use set_sysclk() for 
telling their MCLK to codec driver. For fixed MCLK cases we need to
apply constraint but for variable MCLK cases we should not set
constraints at set_sysclk(). How can we identify these two cases...?

For example, if machine sets very low MCLK once, the driver applies low
Fs constraints which I2S driver cannot support to. After that this sound
card cannot play/capture any Fs rate. It seems set_sysclk() is not
called if Fs does not match constraints. So we have no chance to
reconfigure MCLK by set_sysclk().


Best Regards,
Katsuhiro Suzuki
