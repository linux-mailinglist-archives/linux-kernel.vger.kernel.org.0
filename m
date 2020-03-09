Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EAE17D743
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 01:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCIACZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 20:02:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38468 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgCIACZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 20:02:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id t11so8896031wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 17:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hK4xlcXzNj+/NiSpFVaUsBvzay5FMbdjodPOBaSR+54=;
        b=rrjgJImO6Ub48d+WhloO5qZ8V7wzwH0ZTFqN4PhxlBAddJ4YkRqG2d+iRQWMrt6qjG
         1AXQTKZ2RYkWWB4KtPBcBVx3QJf2v8SZs7ooa+bzBZLxKKp+xlU1PAKRn6IZTS1wYq5F
         YdV6Tbkzejv41HfkmUO1KbSrPbdm2WJr4BE3NAAq+WjvRDqzg2cxvroxBkhddvk9JgMx
         4pPDnxLnD+NxXy6ieFhoWCvi4LK9molJgTcz5Sn/hH1Yu39O2wm7kruT2XxWH/ge30O1
         pcD8bdkvsWKb3YJKgP7g4S1RBwxt/W2YKLQGQsyFfHC9TxD1oHaWeJMjhTyn1V9xpfCF
         SKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hK4xlcXzNj+/NiSpFVaUsBvzay5FMbdjodPOBaSR+54=;
        b=UkNquhazPHGaH5PbxkDvtKgZJbsGZ5LAsFlQQpahFVe4SvwbfEl2p+4alTIhvl+3BC
         JdZSbTtreJ5n37+lwc3AjmUD+/ymbOJy5ere30+mXoGB2purn+9GNr09ewBD8Njs6i/G
         iPiK2WW0B6c3hHS/iLSEMkGyePRAvrZKrj6NPSLfPAIXbZ5DfO0GBrigJOuQt0tMo2Wd
         6G5CTbXgLsqZaxH+9xfUkxAAeKHLFdPcWeLlOkw2MRk5dJlTFkUzmYyba1uBZxKjb2NT
         mEVK/91Ysyf8+lDbv7qASjJLwnqhv68JhdjEn+mcf5PeBX2qvG0vhGXj7hzamWz+uLrf
         CVxQ==
X-Gm-Message-State: ANhLgQ20gVK7kzRWs8Xaw7PzJbxweA6fysOvIvCXS910MNFXRIxLk9Rt
        ntQMC0sq0lX4or/gvDe9PoHlyRvj8Dw=
X-Google-Smtp-Source: ADFU+vvcpVD2BBr21XV5V74WxEJ+jq68kqKsLx+kRhH8r4lgNy97t9IA/NW1D66p0ivwJacXGAQpBw==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr18070723wro.254.1583712141599;
        Sun, 08 Mar 2020 17:02:21 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id l5sm23349679wml.3.2020.03.08.17.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 17:02:21 -0700 (PDT)
Subject: Re: [PATCH v7 00/18] Enable Qualcomm QCS 404 HS/SS USB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org
References: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
 <20200308052302.GJ1094083@builder>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <dfc80be3-92ae-361f-0b1b-cb9913ee06ba@linaro.org>
Date:   Mon, 9 Mar 2020 00:02:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200308052302.GJ1094083@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2020 05:23, Bjorn Andersson wrote:
> On Tue 03 Mar 09:11 PST 2020, Bryan O'Donoghue wrote:
> 
>> V1:
>> This series enables the Primary and Secondary USB controllers on the
>> QCS404, associated PHYs, role-switching and DTS descriptions.
>>
> 
> Finally took the time to give this a spin on my QCS404 dev board.
> 
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

thanks !

> 
> As this touches three different subsystems, and doesn't have have
> compile time dependencies between the parts, I would suggest that as you
> fix up the build error I reported yesterday you send v8 as three
> different series - one per maintainer/subsystem. That way we avoid any
> questions about whom should merge what parts and in what order.

ack, will do.

---
bod
