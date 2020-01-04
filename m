Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4293F12FF98
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 01:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgADAdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 19:33:23 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38594 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgADAdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:33:22 -0500
Received: by mail-io1-f67.google.com with SMTP id v3so43140831ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k8CKT1is0EUxteWZfaLzNNpxRWfsUWmMNgxluVtAzcQ=;
        b=gSZQPCtkrfu6MUJ6dSYfp5NZAfUXLskrs4Y4KfHyDqPcuYl4sB44jMta5DUZrYI04k
         T3Md2vaDhrQmzZiDeB/ifIA+SBe7hQP5DBBKKuyWThx9owwcAkW4lR0ulU6V3YMH1Z0p
         bsgwkzj5tkf3Lo7buaLjbvq60vRExRKf3EoMicEd2tP/Ju6PjW2mywewZQzrLoLauI36
         NSkRyLTk8NDsDgRy2dgylykOXVOyutqS9laSRB3rTrPOIoLu2+osOln+HjsVjDTQmDX1
         zHT5nKeRsVqtDfJl6SDdQa5LAel9Oko4jzxQpGo8BWQvmEATE/gWY+POotekPBa6GzHI
         sB5w==
X-Gm-Message-State: APjAAAXZQZzy3WqW8SmCEl3QH3OaS5ECXJ6KAjR5WfSIHC5xOraeh/wG
        0BGthe1m4tJKDRMOaQrBdohbsT0=
X-Google-Smtp-Source: APXvYqyWiozwuhjQ4SW7UTaMndher3DAycu9m/2IHGaVxnrRXLDPuv9BOqeWZFxceWcHuaQIFqyp/A==
X-Received: by 2002:a05:6602:280b:: with SMTP id d11mr60257522ioe.250.1578098000969;
        Fri, 03 Jan 2020 16:33:20 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q65sm21442297ill.0.2020.01.03.16.33.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:33:20 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219ec
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:33:18 -0700
Date:   Fri, 3 Jan 2020 17:33:18 -0700
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>, David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: clock: Add YAML schemas for the QCOM
 GPUCC clock bindings
Message-ID: <20200104003318.GA5129@bogus>
References: <1577428714-17766-1-git-send-email-tdas@codeaurora.org>
 <1577428714-17766-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577428714-17766-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2019 12:08:29 +0530, Taniya Das wrote:
> The GPUCC clock provider have a bunch of generic properties that
> are needed in a device tree. Add a YAML schemas for those.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gpucc.txt       | 24 --------
>  .../devicetree/bindings/clock/qcom,gpucc.yaml      | 71 ++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
