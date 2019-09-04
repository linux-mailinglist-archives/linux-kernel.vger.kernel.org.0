Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E342A8D35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfIDQgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 12:36:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39184 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbfIDQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:36:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id n7so13844032otk.6;
        Wed, 04 Sep 2019 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VcLNSQo/FpdNp3KI0MMID9sL1HTgtVBFdNj0rcgjWQ=;
        b=OSJ8FAFn7PHtQnI6r5/8bF6vcGMsBLIq2P1OEk9r1Cby0dXAi0TRm/YXbZ1WElFTSM
         OwxDHhlBX8TsCy12cYtdufDLUX6/fxQHGqsuTv03rEf+R2Zw2mvJD+ifztkzcAexyFJK
         xOeSf0cM+k20diCmK/WAiN8eDj1HV3GZQk5eHxrdw3eQfBAp1IHECv3cmB7rSqAAQOrB
         IZgRVwTZT9SHWPUlEZiXn6NsjP211pqbSkIKPBN2hG73Iq/S2f/oTgUCVe9iYkXjbVjl
         Dmx9CoeErSplTi/ZYZ93aEYLYwYUxwuA4GOtTSNZWAnJoHLRoMbH3dOWaPQANTDCyfI+
         YiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VcLNSQo/FpdNp3KI0MMID9sL1HTgtVBFdNj0rcgjWQ=;
        b=XknCuE9hr+h8cM9jAS5D2sLXsHwW9jip5VIDoS3PVYsO54aYFr34SxEtSjiRprJAtn
         biLWT6iOWZICjamr/TtH9no66mm9I8CxxjqYL9U1KI906oZ8hS2SyUEz5NzGzwEwvaN/
         T27uLJ0oLKK848Axafq3cvFXFJmiqjOblgIv5cHAOh+23PPGw0LbXze0+p6pbxCUT67V
         54gttYMzxMBlaWs6wSUII26I8oufui9cSDqYh2opszr2Vm5AcaxMoEhpYCXUR11twWJG
         z7w5cqgL0lZRygwQDlhuEBa5nU8Ck2fpfZuFXwsn0irpyuGUckqwTB0cClJrgmryFels
         AFrw==
X-Gm-Message-State: APjAAAXLV/e4wObSHOLjMqEU8ZgLMTgDxCUqubRWjJ49Yfeh85IWKmjX
        R6pjzWgLuT/R3thEiixPEZM6eZ+hVxuFvTB/tV7XxpAw
X-Google-Smtp-Source: APXvYqxVwdwlZkT1M7Z+FTlrgM/3cXgKH32gOCFlO1BhA8Z5xZViduosC/Nigzkht2IeSZZMalE9o+m1sgYNm/UGDhM=
X-Received: by 2002:a05:6830:1e5a:: with SMTP id e26mr7631053otj.96.1567615012911;
 Wed, 04 Sep 2019 09:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190904114014.124099-1-weiyongjun1@huawei.com>
In-Reply-To: <20190904114014.124099-1-weiyongjun1@huawei.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 4 Sep 2019 18:36:41 +0200
Message-ID: <CAFBinCBo2Mf_7jXiNLoP7+t+TGVA9PmM9zT+Ni+1=q6OH1cU6A@mail.gmail.com>
Subject: Re: [PATCH -next] phy: lantiq: vrx200-pcie: fix error return code in ltq_vrx200_pcie_phy_power_on()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 1:23 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Fixes: e52a632195bf ("phy: lantiq: vrx200-pcie: add a driver for the Lantiq VRX200 PCIe PHY")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for spotting and fixing this issue!
