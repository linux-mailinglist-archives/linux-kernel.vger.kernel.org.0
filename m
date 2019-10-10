Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F318D3064
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfJJSah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 14:30:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43401 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfJJSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:30:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so3187582plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=ps6OX7J+R0v4L7fcM1T7Wzw2f1GKAPmugB6t5dSsqkM=;
        b=HIIqMfHz6wO62lQ+X8N+ZRYKyDUSgJCarKOH+liGUr7ncdhzM9FwnaXuDMaBl7aqR6
         dtDh7KfWgZSmZHnmQeGwqXoLPwaImuIMgnwhUM2wIBy+Na6mPxc1K2N0m2IBpGm/FURD
         N9kx658NZs15O837L45HTjijnDLKLkfgFFwE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=ps6OX7J+R0v4L7fcM1T7Wzw2f1GKAPmugB6t5dSsqkM=;
        b=N9S2v0vr8RaNgRF5WcVy/0iCFBwgblKqARJnd/zaAA7NpMMgkKQSQaBRRjYB3HfUS0
         Eksae9XQL7BXkDNa0ZYNqL2xfJhHs4Zkzzl9x1R8mP/oTTkEopCKo4y4vgkdEJlMCBop
         vJFRCWoOtm5ak5P4ueQTBEg18XSahJzrY6tkOoWJ4e57rZbhcPbCgzoqYmL9x59YHmdW
         50CB/DhKmJNiie6bj5jhmqvTn235VvC/bLQkRdUL6WbTScPmp3LU2IRTxXHm/p1zbroE
         oQSdPWrQl7wVSV+v6rmar+Eq0vZW1B8BGO01tGKgDa26cQwgPmudTIIfFmUCOhyUZYga
         DZzg==
X-Gm-Message-State: APjAAAUdGTOeeOcygxQ3//TCw5yS1d/wCcs5thiqtlMm3LTWrtAahfLF
        eLseKKElXBwCcBlGbpDjkZjfgQ==
X-Google-Smtp-Source: APXvYqyoLW/EJg7p8v3RXM5Bo6G6Vo82R4XqUo/NBx+bsuAZdRBQaNMvdyc22ZWtFobd9xYBPAb0lQ==
X-Received: by 2002:a17:902:bd08:: with SMTP id p8mr10948195pls.248.1570732236345;
        Thu, 10 Oct 2019 11:30:36 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u4sm6601820pfu.177.2019.10.10.11.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:30:35 -0700 (PDT)
Message-ID: <5d9f78cb.1c69fb81.65dfb.6f7f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1570616148-11571-2-git-send-email-Anson.Huang@nxp.com>
References: <1570616148-11571-1-git-send-email-Anson.Huang@nxp.com> <1570616148-11571-2-git-send-email-Anson.Huang@nxp.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Anson Huang <Anson.Huang@nxp.com>, andy.shevchenko@gmail.com,
        davem@davemloft.net, fugang.duan@nxp.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     Linux-imx@nxp.com
Subject: Re: [PATCH 2/2] net: fec_ptp: Use platform_get_irq_xxx_optional() to avoid error message
User-Agent: alot/0.8.1
Date:   Thu, 10 Oct 2019 11:30:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-10-09 03:15:48)
> Use platform_get_irq_byname_optional() and platform_get_irq_optional()
> instead of platform_get_irq_byname() and platform_get_irq() for optional
> IRQs to avoid below error message during probe:
>=20
> [    0.795803] fec 30be0000.ethernet: IRQ pps not found
> [    0.800787] fec 30be0000.ethernet: IRQ index 3 not found
>=20
> Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to plat=
form_get_irq*()")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

