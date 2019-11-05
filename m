Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A643BEF5C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 07:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbfKEGvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 01:51:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35317 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEGvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:51:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id x6so8879053pln.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MLZvtTZXNfvRWFvhu+xZrbhbWxZa6520w7xc3DnxMfk=;
        b=ovFzPiyueyG5Yh6NS3lam6dcbSJjihEjm+M4xFDqkGmjUXjx//55rawC9WZoTAjUsu
         A2Xy1v2lrnDeGPeUC3k+4sEuLT7/yKwKfiYk7xxItUg8cYGd1fI4ySLpzzPY+vmrqM5l
         JjI20g8GwXjM0iQlF0516Cs1zx7PREOSiY5GOCJGmNAIZ3UXdF50ntGkynitHmrg4Ns2
         StTckSIMgd0t9xWKYktljntLr2DHLTVnGbeyDo6pVMh7Xve2n4Jz9ODdatcMI3zFZU6g
         /Lk+U4N0JDLfXsHuBZl3dAPUcPkKNQrv+9kSj9KRdQECaeSsuKbIb7jhX3RYakGm4+df
         v3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLZvtTZXNfvRWFvhu+xZrbhbWxZa6520w7xc3DnxMfk=;
        b=qTNMPi8WsIEHf2/VdsX0osij6C9n7P+sXPgNWOms/VkJOrjMbsyHqS7Ar5Ogji5Od9
         hFTt5ypTBHMPzmyVvpA4FHKS0UJtrMC3RH3APYFKt/SaSABICpEupP6TeWwu7DMj6Ib2
         B9eYQFNlGuWX/T3hLMC69iFPGjkFB8sVv9jIQnNvREb4Iww7Z2RTu6NIhSw6/0bA5NOA
         YI9/trGWKf2UEtVS5o0Wmdm5THwigk3zi0efr23LLf64hD+SazevITX/h9Ob9cARE9aQ
         vtsuHde4jSWUC6eMfqHOWQaiA47fHuikLGps4wokyrQhX7AAFL4m2zOKVqcerNePFpvB
         HYtw==
X-Gm-Message-State: APjAAAWylhTEdFVmHwry/pvEgOkkVSeciFt8ZlN5VUoIaolq6uMmpnZ1
        D3wzB1zy66moJ0PDqVh6ssaXmQ==
X-Google-Smtp-Source: APXvYqygTQR1HLlTaiQfWLrNs7Ep8bXeQMuApptnCYjO/5t+FBUMcOI0Th7332U5KHVlcuUUK4d/pA==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr7331351plp.61.1572936665309;
        Mon, 04 Nov 2019 22:51:05 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id s69sm7227648pgs.65.2019.11.04.22.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 22:51:04 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:20:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, daniel.lezcano@linaro.org,
        edubezval@gmail.com, ilina@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tdas@codeaurora.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 5/6] clk: qcom: Initialise clock drivers earlier
Message-ID: <20191105065058.yhqgvilti6cdzph2@vireshk-i7>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
 <5f1ca3bfc45e268f7f9f6e091ba13b8103fb4304.1571314830.git.amit.kucheria@linaro.org>
 <20191017174723.8024521D7A@mail.kernel.org>
 <20191018060345.wjflngfdnqa3gbsu@vireshk-i7>
 <20191028172225.1B1CF20862@mail.kernel.org>
 <20191029010605.GB27884@e107533-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029010605.GB27884@e107533-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-10-19, 09:06, Sudeep Holla wrote:
> On Mon, Oct 28, 2019 at 10:22:24AM -0700, Stephen Boyd wrote:
> > Quoting Viresh Kumar (2019-10-17 23:03:45)
> > > On 17-10-19, 10:47, Stephen Boyd wrote:
> > > > Quoting Amit Kucheria (2019-10-17 05:27:37)
> > > > > Initialise the clock drivers on sdm845 and qcs404 in core_initcall so we
> > > > > can have earlier access to cpufreq during booting.
> > > > >
> > > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > > ---
> > > >
> > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > >
> > > > Makes me sad again.
> > >
> > > I am wondering why it makes you sad ? :)
> > >
> >
> > We're playing games with initcall levels :(
> >
> 
> +1, which will come back and bite us hard soon :)

:)

I don't like reordering init calls as well, but only when they are
used to avoid issues and probe things in a particular order. While the
only thing we are doing here is to get things to probe earlier, which
isn't wrong IMO :)

Lets see if it bites us anytime soon, I would be surprised really :)

-- 
viresh
