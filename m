Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773051769F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 02:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCCBZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 20:25:36 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35113 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCCBZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:25:36 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so1360707oie.2;
        Mon, 02 Mar 2020 17:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WAXBNHPCyb2lFOMu94mgI7aelx1+Q+5p/dvXK5YvRHE=;
        b=P1Ki0S6IlmFlo5oUTu5TjsYp2950Wp+qKgT7eBIWl5h/uzvr33YAEeBelJXTN8mofe
         PBgP2xHiZq7iaScCda9o1sOSnIaLz3eDSFjNC96HbqTz3Itw0YeVIYYcsQ7dxP+YFZV+
         jjzIUuWI0izPzdIKY9vWCkA9sBBbRYAFt7C9sn6A4B0Jgn87irhKYtvG3PJK4VEKAfjo
         wxmo7tPe3hqjIF3+i+AOIwho+UBvp6H6Z32bbMzvg2OCm6jUiHWleGhG9rR2Ls7WP4k1
         7REurxBmEcGmeuIWEDHlvN+nJrH65TIXlUd9Hc2yr5h8wbK7SjdUGAuikq5p7QeQMSg7
         PrEg==
X-Gm-Message-State: ANhLgQ3wsefRKfJxWFABQY9ulmAKTFlUmhG9cjsdMqiqngzbUaLQsgfq
        kBbdcuhRtgVOitdwtwx3sw==
X-Google-Smtp-Source: ADFU+vtQ7yM80ayNWk3xk3Uufcv74VNMFXOaCMRX8dLTT8SCSmb+XnwNUNAFH0RHjKAP+4bPqHQN+w==
X-Received: by 2002:a05:6808:1d3:: with SMTP id x19mr893356oic.77.1583198735464;
        Mon, 02 Mar 2020 17:25:35 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e10sm6674155otl.0.2020.03.02.17.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 17:25:34 -0800 (PST)
Received: (nullmailer pid 3532 invoked by uid 1000);
        Tue, 03 Mar 2020 01:25:33 -0000
Date:   Mon, 2 Mar 2020 19:25:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, logan.shaw@alliedtelesis.co.nz,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v5 3/5] dt-bindings: hwmon: Document adt7475
 pwm-active-state property
Message-ID: <20200303012533.GA3454@bogus>
References: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
 <20200227084642.7057-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227084642.7057-4-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 21:46:40 +1300, Chris Packham wrote:
> 
> Add binding information for the adi,pwm-active-state property.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v5:
>     - change to adi,pwm-active-state
>     - uint32 array
>     
>     Changes in v4:
>     - use $ref uint32 and enum
>     - add adi vendor prefix
>     
>     Cahnges in v3:
>     - new
> 
>  .../devicetree/bindings/hwmon/adt7475.yaml         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
