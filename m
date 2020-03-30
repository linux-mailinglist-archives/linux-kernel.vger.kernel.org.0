Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58BB198546
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 22:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgC3USA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 16:18:00 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37812 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgC3UR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:17:59 -0400
Received: by mail-il1-f196.google.com with SMTP id a6so17193390ilr.4;
        Mon, 30 Mar 2020 13:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q71QqG45ljUuyOkAu10gdbtg55IDdL7geZOpFag6FLQ=;
        b=TNpGa2MZf5x1vWZxPRtHxQcED/XJyv3YgOJlgMGNegUZP7UhdbDBb6AqmpZhCfxP7A
         l4MhPOPjV2mbATcDVGN3qKGn7/R82EKu60DQ9Rl6hSqLOwjCCRVrAvnrKGrpcIYPX6kv
         0UqaDXTeDdyRU+A/fUGM5J0hP5f6khXhw1Ky9yuTGPD6F6Cz1TY8SmtiubEXdaW25hNt
         ssrugtbM/CogXEzZds++33Ky1eKGYp57T0cLdo6LtzDxpypPvhPwm3YmfnHtXZ4PvwSF
         8FMsVbCQtF9HVZPnlL5SQvrbkPjURGmp/j5IeSuMe/xzJk3yXycUCp480qVKpABZRj8P
         IdQw==
X-Gm-Message-State: ANhLgQ3fDDahevaXQ1sQl4+6cptW5OAelTMZl8woXyCC0y1PAncHCBDZ
        onzhcNQvYGeUCp/F3A9E6w==
X-Google-Smtp-Source: ADFU+vuzfhv3JTBM4oiYI3Y9naj+3VVz+nORgDF3So9FBU8mSYEkOoXKUyfDVismEUCUX+BlzyP64w==
X-Received: by 2002:a92:448:: with SMTP id 69mr6642621ile.197.1585599478469;
        Mon, 30 Mar 2020 13:17:58 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d15sm4336007ioe.49.2020.03.30.13.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:17:57 -0700 (PDT)
Received: (nullmailer pid 6853 invoked by uid 1000);
        Mon, 30 Mar 2020 20:17:56 -0000
Date:   Mon, 30 Mar 2020 14:17:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: Add cros-ec Type C port driver
Message-ID: <20200330201756.GA14707@bogus>
References: <20200316090021.52148-1-pmalani@chromium.org>
 <20200316090021.52148-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316090021.52148-2-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 02:00:15 -0700, Prashant Malani wrote:
> Some Chrome OS devices with Embedded Controllers (EC) can read and
> modify Type C port state.
> 
> Add an entry in the DT Bindings documentation that lists out the logical
> device and describes the relevant port information, to be used by the
> corresponding driver.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v5:
> - Updated License identifier.
> - Updated DT example to be a full example.
> 
> Changes in v4:
> - Rebased on top of usb-connector.yaml, so the connector property now
>   directly references the usb-connector DT binding.
> 
>  .../bindings/chrome/google,cros-ec-typec.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> 

Applied, thanks.

Rob
