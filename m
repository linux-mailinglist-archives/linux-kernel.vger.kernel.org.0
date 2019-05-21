Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4E0258B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 22:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfEUUMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 16:12:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45608 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfEUUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:12:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so1729pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=nGAz3/K7nDgzHUkL2D1i6CIQezGgnUsjYzvazG8X9DqvbZi0EVhUOGAifW2QuFKnvb
         LPbgTo9xZkZKG/71s03GLv/A/1Pg8SVuwZu0XzfrlwB5uV9srfccGrKOE0nkFASqsHkz
         FADTnbSOk/bhT92J9sej8s/kKgurOQRgWuvwOijz4gwS3WpI0tO32QLhXNzrJu/vl80J
         SImh5Q8d/8LpBUNpY8cPuudNDGJG+tpId07FLeBfDDRPbBWFCtta5M8dtAx9y3LdlFP4
         4SgyHSHbpnu+FW6O67mG4izAbM3V/24rAyt83xuCC7FYypjs6RJKO9g/vi0NkNEm2r9E
         gTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=EjzT8U3neXPw5wPa751dMGoRMbfv0QkyNvuU4L752ZJvmmlGQNAXduKWjPm9B0VMbJ
         VC73WFC+DmJIGVr1T685q+pA/MmwE2ZxP6y9Uoy6hFrOKOwBPdd6KJC0nFoMWvcQYJnW
         jOjlPup30poflAYaXibwXASBPB/bGaPhTJK/x0N9DHO5JEdfJP65INPDp41HxyWStlen
         YYIiIDQcPVCVVKdexlwEM2kC0FJkQNqbz/ZIx/42JE5PMSjLYDJSP/6ERYsc/95G4+QS
         WwxRR9fom8ZFIPgv1hfL2vjOGNosVMZljN1K2GbDhTtuMYeXX2ESsbMi7GHHN+4rXgLG
         RvRw==
X-Gm-Message-State: APjAAAXKoLIAg47NllGq1Kfesqb9Zx3UXtookANbT4fnpXz0J+ezhveA
        IPTRU/JBlqfL0KH5dUSTqoyPSg==
X-Google-Smtp-Source: APXvYqz7BB/aqbr8wvZrYS3zm53Qa+Pz6ZrLainUe1XyeFYrKx0BPyui0jV7qdhS8urpyEaQbyptOQ==
X-Received: by 2002:aa7:9f01:: with SMTP id g1mr77010922pfr.259.1558469567850;
        Tue, 21 May 2019 13:12:47 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b1ca:3800:3284:d770])
        by smtp.googlemail.com with ESMTPSA id n27sm48379192pfb.129.2019.05.21.13.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:12:47 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] mmc: meson-mx-sdio: update with SPDX Licence identifier
In-Reply-To: <20190520143647.2503-3-narmstrong@baylibre.com>
References: <20190520143647.2503-1-narmstrong@baylibre.com> <20190520143647.2503-3-narmstrong@baylibre.com>
Date:   Tue, 21 May 2019 13:12:46 -0700
Message-ID: <7h36l77eip.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
