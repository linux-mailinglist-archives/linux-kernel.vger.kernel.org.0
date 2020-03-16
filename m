Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B355187062
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 17:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbgCPQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 12:49:04 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52010 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbgCPQtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:49:03 -0400
Received: by mail-pj1-f67.google.com with SMTP id hg10so4719819pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=h0lz/JWrV5mBVYYmE31rxyRYjDlj4PusyG3VqpF4T6k=;
        b=hJIahldB3kwBLmF6WEX4+g8T/gEoJF2F/Zu1jmwyaJFvNiPSoqrfsVl+yWNPucXmIC
         r3NFvkbEXQl7516mNRO+UtEwwJyl5SVVupUXNEA61yHib90qcteXAJwwcWxRgyJgMVNJ
         pKlnibyS2ab8X3VmKFnKDEvW8CYKK8R91yqmg0TPW686zsVYvtQrJc7MvH6/PDOsErBO
         h3fiqhzxUa59KRwSz039ws3/pRdwN6iDO+xiNJffBT/cSCpP8hKzpLC2rmMDt+t7DX6C
         hnCktZvmX02Slz537BiZqERfy8gvfVw7Sa0lNT/vWhdvZtpB2pdyvjPoLxlfp9a4zZFn
         rXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=h0lz/JWrV5mBVYYmE31rxyRYjDlj4PusyG3VqpF4T6k=;
        b=LX8eOECAa28RnKd4SSrKdXs0z30bbYA26dS/dvCkThx2sMPU1He3pnyll7o8QT2ser
         pmjPPbWr7JFWF0nKADnxF2vOnS3vCkRnbl0QA6EXToV3pKuu4WL4XF92nC9BgpZyDfa0
         7cleHFwVKgY15Fd47OsUhWguuN4brbkkDfWIC4Gy2dSpLG5QpElnP0oVlvrmfOOl6cOa
         cn2x0cZL9dzv5bsE9ryLmSy25g1gNxp2hQWcFnHJKusRx6JFGMwclUOSqDILkCU3Xc1f
         5VpnxTpsPWpx73d6Y50u8ApuPELxsyZJXOQjni3TGox5QdKZTuWfe0iSSjtkiBkH7vK/
         E4Dw==
X-Gm-Message-State: ANhLgQ2UPA0YNI1vV1a0nIe0neCtVDxsg4l2JHabP78h6CDNy7eLBkqI
        iux0qLqJJPhSKXzkISUf6Y/fYQ==
X-Google-Smtp-Source: ADFU+vvHnb3P6+r+gPmJOlmhsfZRus2ot8Z7/8HVSaasGivs9AufsgyzegE0B/1zCvhyMqounZtaVQ==
X-Received: by 2002:a17:90a:a890:: with SMTP id h16mr447564pjq.55.1584377341627;
        Mon, 16 Mar 2020 09:49:01 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:dcc4:2a10:1b38:3edc])
        by smtp.gmail.com with ESMTPSA id e24sm407119pfi.200.2020.03.16.09.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 09:49:00 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson-g12a-tanix-tx5max: add initial device tree
In-Reply-To: <1582991214-85209-3-git-send-email-christianshewitt@gmail.com>
References: <1582991214-85209-1-git-send-email-christianshewitt@gmail.com> <1582991214-85209-3-git-send-email-christianshewitt@gmail.com>
Date:   Mon, 16 Mar 2020 09:49:00 -0700
Message-ID: <7hzhcgutxf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> The Oranth Tanix TX5 Max is based on the Amlogic U200 reference design
> using the S905X2 chipset. Hardware specification:

Similiar with the other new boards being submitted.  Can you make a
U20[01] .dtsi to share between all these common designs?

Thanks,

Kevin
