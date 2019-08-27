Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE5C9F3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfH0UH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 16:07:56 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38658 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfH0UHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:07:55 -0400
Received: by mail-oi1-f181.google.com with SMTP id q8so256675oij.5;
        Tue, 27 Aug 2019 13:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bWyl2iisBFJ2oYdkoeRFrWQZ6jcjMOLOjACZ2X7fsGE=;
        b=AcoratEZIzdCRNgimmbDMSXVJ7ocXG1n1PL4M5d8oUbDFu2VcsHrGURNQAnLU9DtiV
         qWYFV6hZo2s5HZXSYS07jfsVRnZT+4aHnhbp3+DgoTERwnEjUwXyfz9EPZqPLFsgGE1w
         JbYqlfHg4d/cMuBnLG3coDBIMsHNKDSj8qBGLBggbBAdHajKjXP/ThCyDRvXODd0M5ed
         0DgTmsa+bHmM0uOdk5PJmhTmXD4zBY0s/fPsZ/VqFQgLdYZ7dCN5BzFaoi08xOCS3U0v
         dZ0e21LZOthNJB9kFBVc3XxuzwoAsJQrbUatsR4AhhlxlYR7NIP9Vqst458FFM2fSXzZ
         p/oA==
X-Gm-Message-State: APjAAAXRErAxK7jREZqoHRb8V4q1flq/yEvvBQ/2dyrZj/e9/fB/PAQv
        eAiKP66g72TUXjsvOxYlQg==
X-Google-Smtp-Source: APXvYqwncVMEJP4yiKHQbSJqXQLy47/hf6kU1kBVORl25CP99fakof14E/vcUdgsmyARx//2Z5umVw==
X-Received: by 2002:aca:190e:: with SMTP id l14mr360835oii.20.1566936474563;
        Tue, 27 Aug 2019 13:07:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm134806otl.21.2019.08.27.13.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 13:07:53 -0700 (PDT)
Date:   Tue, 27 Aug 2019 15:07:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-devel@linux.nxdi.nxp.com, Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        Wen He <wen.he_1@nxp.com>
Subject: Re: [v4 1/2] dt/bindings: display: Add optional property node define
 for Mali DP500
Message-ID: <20190827200753.GA5081@bogus>
References: <20190822021135.10288-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822021135.10288-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 10:11:34 +0800, Wen He wrote:
> Add optional property node 'arm,malidp-arqos-value' for the Mali DP500.
> This property describe the ARQoS levels of DP500's QoS signaling.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/arm,malidp.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
