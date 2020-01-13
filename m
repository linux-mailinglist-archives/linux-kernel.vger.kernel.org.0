Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0196B139CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 23:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAMWvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 17:51:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33016 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAMWvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:51:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so10687882otp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kHrOCgkkdDXDANIjbqsuSi8zgIrP7fM6uexZoRu9ItQ=;
        b=lRdynINsUGevfqEJ71gwd2/ZQCunfQh0i1YhZTu8FhSVcYkhFEXsHG2YLjBNvFSkzK
         azMR6CIozj6M/3g3Soo+pBaHpdRDDAgtehNLB7Nat/XEnpJTybRoGA0nRimBjK3qw8lX
         kbGQXkmSNkKR2+1TdiCLcBZ3/OghKRJ/sPofirs7fnfx3Jh66A5BWZK3Lwm1EiswZOaJ
         yhO+5uTiX1cykK1tI2tSbwOpVAzoKo81ov5FWHax/IXR0Bx71u3GMuXCAw6uL9SMVl/D
         gd959XxnOvKMGj+Hc5dTkoSOVrZB4jtt15h9PBGT1jXObAqZJH8B2bDtFuI6TgYbCFUH
         OifA==
X-Gm-Message-State: APjAAAVivYpREonl6qrwbptPcsmkzOPY6e0MBORlbSRvWmaU17fpEAEk
        tAt+3rRoFsIDrfKPvDiBhER9fL4=
X-Google-Smtp-Source: APXvYqywDyVSGDzYD7bmdDxa5/6T7LVnfnjyjzLPqQbyEu55lmaV2vjyd4Dv0buk4ml/6HCKTpHg1w==
X-Received: by 2002:a05:6830:151a:: with SMTP id k26mr15607183otp.74.1578955891828;
        Mon, 13 Jan 2020 14:51:31 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v25sm4612772otk.51.2020.01.13.14.51.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:51:30 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219cf
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 16:51:29 -0600
Date:   Mon, 13 Jan 2020 16:51:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, georgi.djakov@linaro.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com,
        viresh.kumar@linaro.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: interconnect: Add OSM L3 DT binding
 on SC7180
Message-ID: <20200113225129.GA16336@bogus>
References: <20200109211215.18930-1-sibis@codeaurora.org>
 <20200109211215.18930-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109211215.18930-4-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 02:42:14 +0530, Sibi Sankar wrote:
> Add OSM L3 interconnect provider binding on SC7180 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
