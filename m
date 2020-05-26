Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 135B119A1A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 00:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbgCaWHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 18:07:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39148 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgCaWHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:07:53 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so9069084iod.6;
        Tue, 31 Mar 2020 15:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5jFDRQ3p3qRPuV6qB3ol1PBrY1GBR8eHngJw8cnK5y0=;
        b=gzU/K8ig5EHlBMFCZbAiwEQoTLUHZCYtLH99rdxOXrVm6EOli/X0ytwzbjC4ZANhFc
         Eedqbw7AjMWRcc7Jz2ra3gedvSJMhZI2rKwjc7Chj0OiHk27J4pLKBlfLxiN/wxG7IFA
         VTH6Amy0EOQ55TCavmFLNQLHSFJBekpV36vA+0ykshyTFl9pbP3ZtKI33g/gIH2xBIBP
         xloSE0YM8mV2v/x8pLMg1MfL0ZA5RStP0lZXAy55lDks+T3HSPjvxhZ72TxzHnYTk8UE
         yu9LKX5UuwsRx12MAlOugm5MUhbYksKIk8hXiygQ6p/NayyCBdBbA0Rwiu1GbO3FiWMA
         /pYQ==
X-Gm-Message-State: ANhLgQ2BJTKf4Sh/emm/gLb6QLbc++UgjpMc2pJZCB1tCG7m7Sz3JGk9
        4i3a6ahc/MifgQB515NRGA==
X-Google-Smtp-Source: ADFU+vsOZ9XDcqVDosxfqDU4+XDY4orb9tssBaBpKPj0mUWLS+Wk24xUOkgI6f4frwFAq9spwxOtHw==
X-Received: by 2002:a6b:8e08:: with SMTP id q8mr17874083iod.17.1585692472252;
        Tue, 31 Mar 2020 15:07:52 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z16sm42614iog.26.2020.03.31.15.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:07:51 -0700 (PDT)
Received: (nullmailer pid 918 invoked by uid 1000);
        Tue, 31 Mar 2020 22:07:50 -0000
Date:   Tue, 31 Mar 2020 16:07:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: uniphier-system-bus: fix warning in the
 example
Message-ID: <20200331220750.GA841@bogus>
References: <20200330092218.28967-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330092218.28967-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 18:22:18 +0900, Masahiro Yamada wrote:
> Fix the following warning from 'make dt_binding_check'.
> 
> Warning (unit_address_vs_reg): /example-0/system-bus: node has a reg or ranges property, but no unit name
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../devicetree/bindings/bus/socionext,uniphier-system-bus.yaml  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
