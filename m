Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5EAF1E5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 02:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfEOAQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 20:16:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43439 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfEOAQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:16:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so346598pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0Ng7RtwdZZGuEsOpcg/j6BSGX6h3Rm/jbhnAJUw5oaE=;
        b=CQMSu4AsDA4jTq/54A4Tfxoci760WoknUl8ChC2k38YH7PvZ8OdcZ+iO6irmFfaY1x
         JBW6jiuQspi5NKeF0VXIZYfFbjWBDiLdW4XsozqCn9NXmtHTKqjKeZ6xYHlkozvArdvC
         auOtVUnxxgcko7dyxSUJNG/8/rQQBm+O6olu9tEkCgzY3KAmiLe97DsxqQxEnl+v4CIe
         xfwNQ6MfSETkvvm3woIMq9IDxGtD6k2JJ/mAfkFj32c8YOQrPuGu4g9j2SXVsTrrL8we
         dkcIWgqRZGYw1mcAIN4fxwdSI4pz7T81KWtUp0JNdfE9Sqvao1OQYElpARhaU9qjzjgb
         /qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0Ng7RtwdZZGuEsOpcg/j6BSGX6h3Rm/jbhnAJUw5oaE=;
        b=QqClnAxoTTsb7WcCMsWRkfwrnCNHkfFz3ShzENcnZRAzAhDCkamO1LVWhlkS00A/g2
         v2T+Qv3gdSeolYGIlJj8/U3Suc4kiU4kgOOu695lUnO/X0ZaDpi6OQ2vXDi2drx8rIyw
         jDyZ9+JBrBVS+ds1U2Pd5jgM4q/0hQS6HC+MoCOgPwaiXV0KbQFqKiuuojPmtv8D3Z+o
         4xWfRA/fcRHmWkLrnr3EjJDfmsXQ11nVomkNQYVok7w74U0KkcaCa+ZhjAdf/fbT8p3H
         w32lETdyc2hPcGK6RTMfQcVW+qIQhbtMAbG2c1QEktVn9gsiDVhpm2RjEDYkwDrS+Ms9
         v2UQ==
X-Gm-Message-State: APjAAAWBQ8CqXggq4u8lNIV6nMIrzBXRkhWKg2hKswK3vGiBn8cVzPQW
        Bq30MkqePUX2tYjxLBBOnl/XYsfmahVPjw==
X-Google-Smtp-Source: APXvYqzFwnBn+sqOHE9J+Ttd7yMS5W9SdOmBxM99N/CXH4wDHfqTN8F/beBTCzSL6fy1kvBb2ikf7Q==
X-Received: by 2002:a62:7610:: with SMTP id r16mr43793256pfc.69.1557879395077;
        Tue, 14 May 2019 17:16:35 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id v6sm253690pgk.77.2019.05.14.17.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:16:33 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: nanopi k2: add sd DDR50
In-Reply-To: <20190513130507.22533-1-jbrunet@baylibre.com>
References: <20190513130507.22533-1-jbrunet@baylibre.com>
Date:   Tue, 14 May 2019 17:16:33 -0700
Message-ID: <7hk1esd126.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add UHS ddr50 mode to the nanopi k2
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.3,

Thanks,

Kevin
