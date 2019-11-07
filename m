Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C596CF2368
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 01:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfKGAm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 19:42:56 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43215 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGAm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:42:56 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so407036oie.10;
        Wed, 06 Nov 2019 16:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+jCXm676NpywEWdAf4lo3fuBb+Mll4pKKjbBJhrgPA0=;
        b=O0fVsbI10ZMEGFT/gz6kVs1MuQRh4flrEu7yMDeSQxYMrqRElWNXKk9yCZFu4zT5Hx
         lwetC639HaAITNiGVOa83aPX3sn9d5f7RW6Oww2Tvfi5ti+frZK3uKb4Mu8IdiAqpknM
         Q08ZemqrGBLrZmqYOz5Ug3sUmD1UdOv+6Bub628VlzH46vYocxEo07LBo3eGeLHOWbWj
         LKGaScLUflivO55aZmPl9siBsbAuuRddHz9VkgiW1RSs1AFLrcGq7BOb8Z/c/9qlsEgu
         GcYBys8CPTc3E4t4UehH08rzAsssBeuCrAKBU63+pztpdqzS7W1lfbpO35mzfjDmFYd1
         W81Q==
X-Gm-Message-State: APjAAAUjkjPw7dP4hGqFG84zWA4u2opmInZ/z7ZV11F5dH/yTBsOddTU
        xq5a0XH1R2+e0ZFBhhdt7g==
X-Google-Smtp-Source: APXvYqwFd7zCI9Il/rOvDXBEazmenzKa569K1JnbqfmXdXS7AQ3Ly2V2g0lny9aPjxdKR8Suc+ADSw==
X-Received: by 2002:aca:dd0a:: with SMTP id u10mr787269oig.130.1573087375384;
        Wed, 06 Nov 2019 16:42:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g1sm209874otr.5.2019.11.06.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:42:54 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:42:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/3] of: property: Add device link support for iommus,
  mboxes and io-channels
Message-ID: <20191107004254.GB11401@bogus>
References: <20191105065000.50407-1-saravanak@google.com>
 <20191105065000.50407-4-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105065000.50407-4-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Nov 2019 22:50:00 -0800, Saravana Kannan wrote:
> Add support for creating device links out of more DT properties.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
