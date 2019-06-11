Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E83B418BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 01:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407972AbfFKXRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 19:17:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37263 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfFKXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:17:51 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so11400614iok.4;
        Tue, 11 Jun 2019 16:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PGXM9n1A3MHJoOWtSrVLBZpVy6n3fT03mPYC+u2yzcs=;
        b=KoW5eh0n1a8dy56bfNixgtETc4FeInzT2Nl6LwfuKYj+Oy0IswrXdCPp3HWTTDdE0E
         Goep3tAX50yB0vAZTfX5O1PZ45kEWtCZnlh0NEA+MGQzdkC7nZzR86Av7BkWM8Vc3Ah8
         /njLEq2+IJXJ2k2EN0DJuwmC2ROl7VAwArN6CeM8628+YX758NyXRHiaB5G8h5p4MzkW
         TM1vKj7l1aQCpFsjJ0dvkbroaBMVzylg4/008/UdQPR6BW0mZqVuEEUF8P1ru4xq8rfr
         10SspiUMHLW9YrR8rStEWLlx+YSpP/vHf6+GsfX/diRtKe1EWqBZCuhiJFbMLTs6HkZs
         BaXQ==
X-Gm-Message-State: APjAAAVzFaCrZdgcFUlRAc/jEf5TVifZ1NP6xUl3TelLQzprEdNmXsiA
        QtGIwfaaHezhMioGGRRrvIaAmyw=
X-Google-Smtp-Source: APXvYqzgSJlYNXRQ5PeO1q5JXCwxtXBbVtD9W0sKPAIdQYJMHeYR2uSP2GJJzZIJpd/7UFmDO9yxvg==
X-Received: by 2002:a5e:c24b:: with SMTP id w11mr28109856iop.111.1560295070269;
        Tue, 11 Jun 2019 16:17:50 -0700 (PDT)
Received: from localhost (ip-174-149-252-64.englco.spcsdns.net. [174.149.252.64])
        by smtp.gmail.com with ESMTPSA id d3sm1917362itg.9.2019.06.11.16.17.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 16:17:49 -0700 (PDT)
Date:   Tue, 11 Jun 2019 17:17:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V7 01/11] dt-bindings: xilinx-sdfec: Add SDFEC binding
Message-ID: <20190611231745.GA26265@bogus>
References: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
 <1560274185-264438-2-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560274185-264438-2-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 18:29:35 +0100, Dragan Cvetic wrote:
> Add the Soft Decision Forward Error Correction (SDFEC) Engine
> bindings which is available for the Zynq UltraScale+ RFSoC
> FPGA's.
> 
> Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> ---
>  .../devicetree/bindings/misc/xlnx,sd-fec.txt       | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
