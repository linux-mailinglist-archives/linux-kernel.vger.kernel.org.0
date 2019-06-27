Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C180584F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfF0O5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 10:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfF0O5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:57:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42BD52086D;
        Thu, 27 Jun 2019 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561647458;
        bh=V7tnhDpdCEtH0xy4BaUun+rbJC5qQflf0ihlbDGxrYw=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=R0kBGt0GTuwC1Zo9rNGZHKLtrEYrtoQVP7zIoYYbLiFkAPc6AUs1WbNxw9j612hz7
         DBT+YCVJggrBEzdC/GFIogNnciL3PH7tP2xMKT3nLs61+Iu6dRTHwL5vkPOqH9LU/E
         CszflHmvGLcG9DecNWSBoIU5+AvkYk4KBmlHgg7c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561646841-7663-1-git-send-email-claudiu.beznea@microchip.com>
References: <1561646841-7663-1-git-send-email-claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mark.rutland@arm.com, mturquette@baylibre.com,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 0/4] add slow clock support for SAM9X60
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 07:57:37 -0700
Message-Id: <20190627145738.42BD52086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2019-06-27 07:47:17)
> Hi,
>=20
> This series add slow clock support for SAM9X60. Apart from previous IPs, =
this
> one uses different offsets in control register for different functionalit=
ies.
> The series adapt current driver to work for all IPs using per IP
> configurations initialized at probe.
>=20
> Stephen,
>=20
> I send a new version of this since I'm not seeing the patches on clk-next
> and I though you may had issues with the previous version of this series.

Ok thanks. I see that you've fixed it to send plain text. Great! But I
already applied the other patches so I'll just keep what I had. Should
be pushed out to clk-next today.

