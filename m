Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5733111053F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 20:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLCTeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 14:34:24 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44898 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfLCTeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:34:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so4398100oia.11;
        Tue, 03 Dec 2019 11:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tbKbNs/QxN6CUOXQECRFOajifnmUQFCmQwKvQGjgzLo=;
        b=o6904U3eZpx6OI2GgGgORH/+TsTEvQkuXm8wc585nSCabrCg0cN8yWxJoEidkV12KZ
         40NxTaI9eo5ufVfqpkTN6W/ymV0JntnhgLV8ZADpa1s9mlmDgLoo8+Y38hpDzzcxdGla
         wR3z5OSDJjOrWOCwieMybaFYgzBv8fFBzB6PGAi8XeBM91V9PJjlHUHwxejbFNLJGWnM
         ptRBEuFdBRrze199+tssGzxlf/b6pnQlRdegoKIZaScZncMJxUOLn0oi8NAVWhkNBHYt
         ZnkgkapJ2At1HyrpxcdJS2MTsVAIp0KQwJkGd0uncj5drkwr6X5LptEFhEdjPzGRG5jM
         gyQw==
X-Gm-Message-State: APjAAAXpZmo1nDoZqzIDr7dAjTdnO4p2sQcrOZzECp0P+uQJsEDl146T
        l6btuScmyqYqEd8QsauYMQ==
X-Google-Smtp-Source: APXvYqyw232/T6H5ODTFMuTpyZYHJTvhh9c8wpRDE/gcQmFOcRYpXENohq6/itN4aQZWeDKKRk2v6A==
X-Received: by 2002:a05:6808:9a1:: with SMTP id e1mr5184706oig.175.1575401662862;
        Tue, 03 Dec 2019 11:34:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m2sm1436432oim.13.2019.12.03.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 11:34:22 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:34:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v2 06/13] dt-bindings: Add Broadcom STB USB PHY binding
 document
Message-ID: <20191203193421.GA9078@bogus>
References: <20191115184223.41504-1-alcooperx@gmail.com>
 <20191115184223.41504-7-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115184223.41504-7-alcooperx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 13:42:16 -0500, Al Cooper wrote:
> Add support for bcm7216 and bcm7211
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt     | 69 +++++++++++++++----
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
