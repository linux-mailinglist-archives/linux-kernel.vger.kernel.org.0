Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF941257F1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 00:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLRXoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 18:44:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36981 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLRXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:44:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so4612169otn.4;
        Wed, 18 Dec 2019 15:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YlF0qFJvGJmhw6rqM4PG6eG2+fdt2hk+1ZQafnBooiM=;
        b=lFXjHvcHTx77ywScj6ZfhAQndpfwUnvnavUYsE9RGsmbEkDZVCa73VoTh9Wrwsk4hk
         OQyDzvXFXEmUoLP8ywv9axbfrAAg1SL/ynjBvIr+u5JwKIVMHr602SHZEO4OjnPXp3Az
         kJL6xK4Qp2vJ0VqxVtEgF5MW/eSyN6T+D7Y6H09550Rz0SROsxovoYiq7lB7vG8SSwsu
         TRe0N1JIa3Z/0JIg34+rcE+Utf82B7GAPxbEaiPYL4uGlVL+pevByMapgG7AW6RW5MVG
         R9shz5kKj3PLVpR8P2FaGGEoFLJR7dFD/yscuSZaRygf9i2ikLnSMnqTR+LMuZp4w9ke
         oOVw==
X-Gm-Message-State: APjAAAWXtPdd2wBreJPTKESyLdqYyHpt9Y8F3HTtbhgeMA+ek8JNvips
        G6MQEP7aOJka5FafMXylWLcPNoYhfQ==
X-Google-Smtp-Source: APXvYqyotoIIgEYjmC7JDYgNhcyXCVVgRHkSDUlCKqB4u9M0aspWY0htbJpW5qvztzebCkWJL0ubvg==
X-Received: by 2002:a9d:7757:: with SMTP id t23mr5651049otl.315.1576712643635;
        Wed, 18 Dec 2019 15:44:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b5sm1407565otl.13.2019.12.18.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 15:44:02 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:44:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: Add MAX31730 as trivial device
Message-ID: <20191218234402.GA19189@bogus>
References: <20191208225049.21783-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191208225049.21783-1-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Dec 2019 14:50:49 -0800, Guenter Roeck wrote:
> Maxim MAX31730 is a 3-Channel Remote Temperature Sensor.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
