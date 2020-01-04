Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43D12FFDA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 01:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgADA7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 19:59:18 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41784 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgADA7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:59:18 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so38023815ils.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=he5w4xe5758mzPhyknWVdWn5blsV7hMVch+zol3itAA=;
        b=N3vRtneHqyNRJpYJSq8d/mEHruSt6UjuhSntE5uV3cR8GW88NvJ0hXn5BSrchKkJuL
         IttUK3QZSeXypCQnrMl9tBhvH3tRSIa39eahf8bus18EPNMaDfPISx+eKbDjZ5Av/2fy
         rzX01tkqMFa55zMr0/AgJD9aIb/uhdxIGZb7XO6NO6sKCaORGomNwxSfIGw6L5JY9UH/
         jmR7LSQ7UXSQRMUk3U3GilGxLGGP20+lkxqWyDhMLgPM5l13vYVZ5hxbsHOUEJ83E0MQ
         qgzQcDEJxs1+ybu9e7vRmXaPJO98/+yIsbrFVOULIguPP65sQJhC+Ev431uc1Aeu9afe
         5OZg==
X-Gm-Message-State: APjAAAXdQWB7urJKs2rlrgF1bqlUzTJGotWvqUkey8qbWRcbZjPrmiiu
        B/7bxEx7doPUk/jNXJhbqDIJH9U=
X-Google-Smtp-Source: APXvYqy0/kG1xNG0PMdHhZRJB8OEcZukyUs9U8W1vJmSFBE6B4NG0vmiZkhNqgXc9GdQAa6Ja4F7Zg==
X-Received: by 2002:a92:601:: with SMTP id x1mr71952568ilg.35.1578099557410;
        Fri, 03 Jan 2020 16:59:17 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y75sm21412385ill.87.2020.01.03.16.59.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:59:16 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:59:15 -0700
Date:   Fri, 3 Jan 2020 17:59:15 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     sricharan@codeaurora.org, agross@kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        sivaprak@codeaurora.org
Subject: Re: [PATCH V3 3/5] dt-bindings: qcom: Add ipq6018 bindings
Message-ID: <20200104005915.GA14735@bogus>
References: <1578052177-6778-1-git-send-email-sricharan@codeaurora.org>
 <1578052177-6778-4-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578052177-6778-4-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jan 2020 17:19:35 +0530, Sricharan R wrote:
> Document the new ipq6018 SOC/board device tree bindings.
> 
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Co-developed-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
