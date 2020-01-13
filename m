Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81444139D14
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 00:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAMXDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 18:03:17 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44897 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgAMXDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:03:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so9971732oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 15:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ri61tZzvuw9GVovdm8Wr7vnv/tkJpOEIL8vV4DTKISA=;
        b=oNmd4RRdQzGQE3d056pWfCPgXrwupYdMD0A48X4cnqCo7O67g6QNJXLKkoXCt2dSkl
         U60CPUIRLEmNRwhc3C5OMMN5II4QrIeqUOuMCbpbgLnzHW6yrtaR+HofQ9Q1QZcHp1rn
         +uBTczSZTx2IbRtlVZkH+F6IgK7vYEy4Dk1OvVevnMXYgg25trzYMfkzXx64kxKzCOsG
         VxL7NoHDdgP1SNowCRUbi868CtHRJ6kpuA55u0n31HaHeiE0UwDrd1Qs4aNd7tuLJujp
         yYma1u4O9+UJ0HcGRxJ636CaB+UzsIY5aykrecqAqpt7MEY2A1znpEk9ZDFCCMHf5zlB
         NDdg==
X-Gm-Message-State: APjAAAVsc9ttBcWr8d0bFdF3Jp9NhQiVZPTG4TVFTn7KfANJA7E4DbMY
        dI420jTKQurUw4ieiJhCkRFYxUo=
X-Google-Smtp-Source: APXvYqz5Jn1PuVOsPtjYJVAqNUI6FqPPnyTeclTCiW6ld8VMOhYl27E2Ydzfy6PpZpQ7gqCs5+EK6w==
X-Received: by 2002:aca:f2c5:: with SMTP id q188mr14944634oih.113.1578956595526;
        Mon, 13 Jan 2020 15:03:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u18sm4678393otq.26.2020.01.13.15.03.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:03:14 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:03:14 -0600
Date:   Mon, 13 Jan 2020 17:03:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: phy: qcom-qusb2: Add support for
 overriding Phy tuning parameters
Message-ID: <20200113230314.GA1041@bogus>
References: <1578658699-30458-1-git-send-email-sanm@codeaurora.org>
 <1578658699-30458-4-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578658699-30458-4-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 17:48:17 +0530, Sandeep Maheswaram wrote:
> Add support for overriding QUSB2 V2 phy tuning parameters
> in device tree bindings.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
