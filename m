Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13484134E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 22:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgAHVBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 16:01:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45075 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAHVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:01:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so4938216otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 13:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PKDSlAFhVxG7yvkR8gMW2sYcjaqMDww08or3P6KMGS4=;
        b=tT9ulSjX35dFNTQ2+z+pYAX4Jkq/qtV8eVHocIqz14qx6xCS5BGCXZOt3XPqk5qHOk
         j2ROM8sHglQZZMCvY5yWRUVUri9LaZe8iTky4hVZLtQc34mG7cYCKiymbNe+J3pg3szo
         kh0RbyNF8Bo9aonkyzuBX/Rc20mlZlEbzsZIuM+UlqwH1kGD2jktTEStnxIAjCghM0e8
         TPpJrL1/M0XA4cvBo3i0ELKPMc4hycXuYVRvvz6uVJzUc2NlW4cu6ZNWTFIXi1930rfR
         As39bYQH6V1U4wKEPpvGy0DlScWP+F9UEiaxGpoxkGjG56WyaRHCC6eBhq3NS4G1Mtsk
         D0ig==
X-Gm-Message-State: APjAAAUMnlwgBz4rHo+PaZ1OlLdixO/2NuyZmr8GasN91DC+6DsEiM8Q
        /TLJlM9WRtxShP+50GEmh8DiM1g=
X-Google-Smtp-Source: APXvYqyjsM2tuDMR+ndQfkkG9eustj73mmAL7NcT7NAw1HCaGU+Dzy/kxupUoWWW+FShdqA7diUlMA==
X-Received: by 2002:a9d:6b12:: with SMTP id g18mr5475763otp.211.1578517311658;
        Wed, 08 Jan 2020 13:01:51 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a17sm1500266otp.66.2020.01.08.13.01.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:01:50 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 15:01:49 -0600
Date:   Wed, 8 Jan 2020 15:01:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Helmut Grohne <helmut.grohne@intenta.de>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mfd: da9062 can be a system power
 controller
Message-ID: <20200108210149.GA27171@bogus>
References: <20200107120613.GA746@laureti-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107120613.GA746@laureti-dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 13:06:15 +0100, Helmut Grohne wrote:
> The DA9062 can be used to power off a system if it is appropriately
> wired.
> 
> Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
> ---
>  Documentation/devicetree/bindings/mfd/da9062.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
