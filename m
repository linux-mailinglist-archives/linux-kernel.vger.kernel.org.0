Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD89CBD2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 10:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfHZImG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 04:42:06 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:22408 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfHZImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:42:05 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7Q8fk0Z012652;
        Mon, 26 Aug 2019 17:41:46 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Mon, 26 Aug 2019 17:41:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7Q8fj9d012648
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 26 Aug 2019 17:41:45 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
To:     Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20190824210426.16218-1-katsuhiro@katsuster.net>
 <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
 <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <f3096961-6b26-1ccf-47f2-978ae3648031@katsuster.net>
Date:   Mon, 26 Aug 2019 17:41:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 2019/08/26 11:53, Daniel Drake wrote:
> On Mon, Aug 26, 2019 at 1:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 24-08-19 23:04, Katsuhiro Suzuki wrote:
>>> This patch limits Headphone mixer volume to 4 from 7.
>>> Because output sound suddenly becomes very loudly with many noise if
>>> set volume over 4.
> 
> That sounds like something that should be limited in UCM.
> 
>> Higher then 4 not working matches my experience, see this comment from
>> the UCM file: alsa-lib/src/conf/ucm/codecs/es8316/EnableSeq.conf :
>>
>> # Set HP mixer vol to -6 dB (4/7) louder does not work
>> cset "name='Headphone Mixer Volume' 4"
> 
> What does "does not work" mean more precisely?
> 
> I checked the spec, there is indeed something wrong in the kernel driver here.
> The db scale is not a simple scale as the kernel source suggests.
> 
> Instead it is:
> 0000 – -12dB
> 0001 – -10.5dB
> 0010 – -9dB
> 0011 – -7.5dB
> 0100 – -6dB
> 1000 – -4.5dB
> 1001 – -3dB
> 1010 – -1.5dB
> 1011 – 0dB
> 
 > So perhaps we can fix the kernel to follow this table and then use UCM
 > to limit the volume if its too high on a given platform?
 >

Thank you very important information. So you mean value 5, 6, 7 are
illegal settings for ES8316. Correct codes are

static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(hpmixer_gain_tlv,
	0, 4, TLV_DB_SCALE_ITEM(-1200, 150, 0),
	8, 11, TLV_DB_SCALE_ITEM(-450, 150, 0),
);

and...

	SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
		       0, 4, 15, 0, hpmixer_gain_tlv),

Is my understanding correct? If so I'll test it on my board
(RockPro64) and re-send patch.

BTW, do you know how to get ES8316 I2C registers spec?
I want to see it for understanding current code, but I cannot find...


> Thanks
> Daniel
> 
> 

Best Regards,
Katsuhiro Suzuki
