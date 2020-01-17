Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86AFC140E90
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 17:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAQQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 11:04:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36747 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgAQQE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:04:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id m2so18107184otq.3;
        Fri, 17 Jan 2020 08:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gY8XscxOcKBlLjDRMHY8EwqFwnexvzxzJDmV4wCRKJI=;
        b=Qz0yR4Qdpw0GLdgS5Nl7hODZEKSz+gDdyEGzfaxDl9FMLSH7gwQy4y2C9P54BP6Y0T
         j/OWHW0KmUNvgQTzng/20h4joxzD9eNCn9HqjDx0nhtQZ+dNcm9GCht9S8OjLL8g463p
         oAKHWAtvuR/BbMKdMoCeCXD6vo6xxH6Z2+k+18LkIqONDhlBiZF/IJAIT01rBhkJ4aj4
         UopFJ+ZAV6O4U6yFJJx0iVXuM0AQE67DCF8ZmrkLWfulT3AAonInrWZIGpqsIzgKkkVU
         qtXvrq9lMvjFph8GrMdl/uciOSperanRLrl1mmhyGaXUoYpN0vP+zl56VO5AqZj7Tw44
         5djQ==
X-Gm-Message-State: APjAAAVTHsSMe3JHN0Sa6d0fRNZPFVTMbOW0F0K6znJWueZ0y4KR2PxY
        nZ9czfIzeqZ/HxlQWXeXCg==
X-Google-Smtp-Source: APXvYqyE9YGRn4YX0kC+viyuhTSx1qKoevOrGze7ruJ/M37j2fW4kY5GyHlfffzYZYaW2JuPQ33QqQ==
X-Received: by 2002:a05:6830:18d4:: with SMTP id v20mr6720122ote.29.1579277066049;
        Fri, 17 Jan 2020 08:04:26 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w12sm8932596otk.75.2020.01.17.08.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:04:25 -0800 (PST)
Received: (nullmailer pid 16562 invoked by uid 1000);
        Fri, 17 Jan 2020 16:04:24 -0000
Date:   Fri, 17 Jan 2020 10:04:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v5 2/7] dt-bindings: Add AXG shared MIPI/PCIE analog PHY
 bindings
Message-ID: <20200117160424.GA16499@bogus>
References: <20200116111850.23690-1-repk@triplefau.lt>
 <20200116111850.23690-3-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116111850.23690-3-repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 12:18:45 +0100, Remi Pommarel wrote:
> Add documentation for the shared MIPI/PCIE analog PHY found in AXG
> SoCs.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../amlogic,meson-axg-mipi-pcie-analog.yaml   | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
