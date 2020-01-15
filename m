Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9813CDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 21:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAOURF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 15:17:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39786 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgAOURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:17:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so17267928oty.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2myqp2GrpN0pfUan1rnrXmWGh+MWOgXmKRvJ9E5COqI=;
        b=mqSQjnsQKZtSq7aH/WGKCRy8WjkE5ODSqFW6GeV9yutVKl4FJ9oWXohgp84bMy27i4
         maFDIGlnPaPJIOXxd2uib9ItoT3stz2wUokyMbMUzdDCViaXOMaSn+SNwYxZ+10THmBu
         E36JpW0209JzvBS4DnCBhi1dM64vM0T1HauZmkQy13oq3NY3k5nZpvpIGuDp2NI/G5QN
         g+BPGhl9JjxNUfJ2eaHVqp5TLaHdja6nHNPd0dWXlFL+95S375F1HmdJqErtp5Kt7tXj
         zZ6VYaZ10sUdqLJnYgMbnqrj4vPnL9BjhcZDv2f0zI9HHlIHsHPxYEJJNZTIw0gzpelD
         ZnBA==
X-Gm-Message-State: APjAAAVVUgl4gCMH/BV4RWioMSOZ1Cnp/SlZT9khAcZrxC6Zou03jhyi
        iY+npMTk1b7nbkZ/AmgF3uqz1/s=
X-Google-Smtp-Source: APXvYqzbYfeHM8YpNrX/HwOegouFADH0FG2eeSgF1gPoN6d8qyCerd+j2USWglWbCr1PhhntiACdmA==
X-Received: by 2002:a9d:74c7:: with SMTP id a7mr4127463otl.7.1579119422628;
        Wed, 15 Jan 2020 12:17:02 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z12sm6892294oti.22.2020.01.15.12.17.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:17:01 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22062a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 14:17:00 -0600
Date:   Wed, 15 Jan 2020 14:17:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: Re: [PATCH v7 1/2] dt-bindings: net: bluetooth: add interrupts
 properties
Message-ID: <20200115201700.GA26654@bogus>
References: <20200115101243.17094-1-glaroque@baylibre.com>
 <20200115101243.17094-2-glaroque@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115101243.17094-2-glaroque@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 11:12:42 +0100, Guillaume La Roque wrote:
> add interrupts and interrupt-names as optional properties
> to support host-wakeup by interrupt properties instead of
> host-wakeup-gpios.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
