Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7140A11F379
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 19:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLNSQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 13:16:17 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:45528 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNSQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 13:16:17 -0500
Received: by mail-pj1-f65.google.com with SMTP id r11so1128165pjp.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 10:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=k6fPKTYuqDNsNSoLPxZubXx3iAFLDMNc6sAuC29KYcA=;
        b=gM0RcaRa9bVy+qq5TW9SRanGBujp7squ5/A/43VewxMFBAVMn6WKusvANs/SrSU+ea
         4yrMFece7MOIiqr8niTdFJDRy0RYEU3s+TQIzQ21H8P1mji84OurJr8MUavctVr7sfv7
         nveSnxYlevZ7kU7H1E353pWSFGxQPGYhfoPFcJpbvyy7APjOAVJ3G1vX9KHxXhUMoung
         6UeN04gsDaCmhRXVq/Az8onJ5KCfMFD9iFpN0NVan7cabEa2uke3OED00564JoRcJC+u
         0yGAZ6Iv+3PjtkrHXg5uQ11tlhE02vosAh+JqymBmU3j+0SSdFiBpDle4QKBulBbR2SM
         e7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=k6fPKTYuqDNsNSoLPxZubXx3iAFLDMNc6sAuC29KYcA=;
        b=XeLJ7RMAOLTTiUri6SeFPQ9AoP11Y5GBYoBLbvQcyIgXu7kOY5XYF8jBt/uQ2EMNnH
         b/EIrcKmqfRQokrHN1oy8ScOeTIxfBWktf4AlasxG07uVcoHRk50XtRfDDk7k9ebq6PS
         v1UsdA0cxI9pHVo7mxzIJ/KuXmnkpUwX7Q6NGi3muWnGuezHBGYNzfQmFGE2rbgEgkvX
         Ou0OwP5uS0rXgn52uUpJKqRkB+uAgOJCQhs+khtuq3siyZj+0UVwMn3/iaz7Exu82PkN
         GyJXy7BF8XRa7x3O0Hsvb4XYQY0Zac7zSqIjvKV5+MW4nrAvYWVJZsObxM1kzYKdjuDd
         muIw==
X-Gm-Message-State: APjAAAW3rWDB2WVfFERPg9FoOZS7dfuS1nSJAAxaPmlyzaLsh3eObEM6
        1ctZwOtcqWtrfzETOdyB0c9QBegHtfk=
X-Google-Smtp-Source: APXvYqwgmEyC7zmUtlhf6Dgb+uFGtuIL7svrumQoIMVRzPs5sE6sn2N24NTcua2KnsrnkTE111nNfQ==
X-Received: by 2002:a17:90a:1b45:: with SMTP id q63mr7292190pjq.118.1576347376885;
        Sat, 14 Dec 2019 10:16:16 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id e23sm13719750pjt.23.2019.12.14.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 10:16:16 -0800 (PST)
Date:   Sat, 14 Dec 2019 10:16:13 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        maxime.chevallier@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: marvell: mvpp2: phylink requires the link
 interrupt
Message-ID: <20191214101613.1acf774d@cakuba.netronome.com>
In-Reply-To: <20191214082403.GA2959@1wt.eu>
References: <E1ieo41-00023K-2O@rmk-PC.armlinux.org.uk>
        <20191213163403.2a054262@cakuba.netronome.com>
        <20191214075127.GX25745@shell.armlinux.org.uk>
        <20191214075602.GY25745@shell.armlinux.org.uk>
        <20191214082403.GA2959@1wt.eu>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2019 09:24:03 +0100, Willy Tarreau wrote:
> > > > Fixes: 4bb043262878 ("net: mvpp2: phylink support") ?
> > Oh, sorry, too early, wrong patch.  Yes, please add the fixes tag.  
> 
> I prefer :-)  Because indeed I only have this one on top of 5.4.2 which
> solved the problem. You can even add my tested-by if you want (though I
> don't care).

OK, applied, and queued for stable, thanks!
