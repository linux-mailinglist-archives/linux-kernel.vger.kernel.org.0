Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6CDB060
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 16:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502978AbfJQOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 10:47:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41581 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502912AbfJQOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:47:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id g13so2099227otp.8;
        Thu, 17 Oct 2019 07:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z80ioQYPpNmtk8h1xfkOdNkYcIk//+vGn82l24tC3Ec=;
        b=ayFVzTCztGpLtHspAthIPiMYYdPoNhmCaXJgQ+lV9/WwBkYzWFUJVF0zu1pjx7BMJX
         nEhEcRbq4j85JmRtBKWx+3vAt54mCp7lfZdLBn8nBQoJSkslmZBS4sjpvsco0moLHWsS
         /D79Dt/zK9hTR6unTy9yPmyes47Q6a3HNP1loaUEPRMKNXJoteJ+DNGJ9vV2BKxA/kfZ
         acO+lAm++1UshfO54ZsCnsy5A1C04iZH9IoCY1NvmrClYdxAo5o+aEHeFfN2PF9Atp5l
         VPEf18TAOwSuU+yzNZrClJ6cYwRAGE7xuNYgYkp0TdL+ZY64kEwAaR5bsOB1fDIPGRjF
         lQbQ==
X-Gm-Message-State: APjAAAUzLXPU+TIwYEAz8v9ClPNKQ9lCSxPfreSYlInq/Bic9J27aSn6
        SxrM+bTroocV1j9Pko77Yw==
X-Google-Smtp-Source: APXvYqxedbXcwY+kWj3j3VwNg1snNtfWuxZ2dsQ49jnmZZAQU7CyljXQg+V0/vcDbf7GjJYWKlOB0Q==
X-Received: by 2002:a9d:6858:: with SMTP id c24mr3254047oto.124.1571323649229;
        Thu, 17 Oct 2019 07:47:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm636635otb.65.2019.10.17.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:47:28 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:47:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC][PATCH v3 08/11] dt-bindings: usb: generic: Add
 role-switch-default-host binding
Message-ID: <20191017144727.GA27542@bogus>
References: <20191016033340.1288-1-john.stultz@linaro.org>
 <20191016033340.1288-9-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016033340.1288-9-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 03:33:37 +0000, John Stultz wrote:
> Add binding to configure the default role the controller
> assumes is host mode when the usb role is USB_ROLE_NONE.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/generic.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
