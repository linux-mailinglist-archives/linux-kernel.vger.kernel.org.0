Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB688107B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 00:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKVXeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 18:34:19 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32814 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfKVXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:34:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id x21so965762oic.0;
        Fri, 22 Nov 2019 15:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/H8wXNOfbxRLTqZKj7EYkjG03fC3qM1eJrt+WodnPxI=;
        b=BZoek13BLxRU7EpdCCCq13KKK6lAvUiE7JF4WzFwvga1+wr6cmeLGNV+hai2L+mt6P
         XrT7nMlIL/2C1AWCIDiAUOxdVCjKX5mc/obn2FjGKoVb5aT5YDn58EuJF6oywkZ6DNfx
         UJDMnAdPgJhIvvU8f8nK/hnyrgeQ7sU0y7HEPaZ21wEGGQE5ilOswGY9AG2UoqXKktzH
         Nz3NI2gp3OWF9Xt7Xsc9zgarnO8HOYEQUNN+kcwwzblQGaYQ0SV5o3OPOx4lgNbEsLjz
         JS6QxC1erViAo2M1nAhL8XgA0CZIN8LHgmfR4JR7u8B8ASswgTNy0TN9A0GbmWyBETEL
         1dmA==
X-Gm-Message-State: APjAAAWOvujwQucQUEjGDDvN7GbynU8K/Er/M8LlRbxEoJccnzZLsmXR
        NgET4/SGRIbnbXp1ooLaDQ==
X-Google-Smtp-Source: APXvYqyFReQGWCWQQxNW++0gPrv20BWVgrq1Wd2zA1GjcAqvNRudJZmfSpKFl6IBnj6PRV4R9P7w9A==
X-Received: by 2002:aca:d483:: with SMTP id l125mr359885oig.124.1574465657879;
        Fri, 22 Nov 2019 15:34:17 -0800 (PST)
Received: from localhost ([2607:fb90:bde:716a:c9ec:246b:67b7:9768])
        by smtp.gmail.com with ESMTPSA id e93sm2729544otb.60.2019.11.22.15.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:34:17 -0800 (PST)
Date:   Fri, 22 Nov 2019 17:34:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 7/9] dt-bindings: interrupt-controller: rtd1195-mux:
 Add RTD1395
Message-ID: <20191122233414.GA6762@bogus>
References: <20191121050208.11324-1-afaerber@suse.de>
 <20191121050208.11324-8-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121050208.11324-8-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 06:02:06 +0100, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Add compatible strings for Realtek RTD1395 SoC.
> 
> Signed-off-by: Andreas F�rber <afaerber@suse.de>
> ---
>  v4 -> v5: Unchanged
>  
>  v4: New
>  
>  .../devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml   | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
