Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7366AD96C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393496AbfJPQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 12:16:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38504 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfJPQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:16:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so11487895plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ResC/hhiygB40CQNO8g6ikuMbA0ju2V41a3xODY1vVE=;
        b=Ha6hDOJlpfX3oR0Lo71lCcmpwUHRfznUaoRUnv6VA0oW8DYo3V3iOQyLrQhSnQHMDH
         1ZqNiwjWcgmcyZNCR5vx+Haaa5wXkWQpq6vttdANH4PDcoef4Xkwm1JLMkYH177KuT9U
         aE0h4rllUx2sP597BRDIh2bm46Peqp4URVGQAF0COhIR3qBtfppzGOgxAypDH0WUJ9Bd
         u3jfndnQaIm/XpKsIRf/sfxd0Nq6lXDXR4k1bVCGe3GEm+2qA8S2Mo2JeuPHeSk8I8Q/
         XUMLkJAyfF6Cgy7WQ4R3zO49FexD4uBIReK0ZZeILFTcqg6NC6smoewkpTm81cIregw/
         3/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ResC/hhiygB40CQNO8g6ikuMbA0ju2V41a3xODY1vVE=;
        b=jnGPR3ZcAOkiks9UdJonxcR8SoYwUtNgs7ygEyQz7eSA1i9bMo3QSZ5STLaO7DB00R
         AQ523rvJolG8kqcQqxKuh9V1lmS+sAXTzyVhEtu0PcSSkXauMRozg7rIvcI7j+jEZeir
         XGkgvb9K/HkxFTIKNiOAmYcbD2mS/xao0ukGZ+sV0GR6D+4FkD91C/9PbMwA92vdD/3W
         dYfPshe876zf9NtCvokuLBYVx6lFrXPR7XmtUEcfcfY2v/q4c6Kt+Ix42jSUwizTayLC
         kvdxwqFHHvV/3pugPwejtq3YNvZsvvxElZl8FLqj93yFNUndoVP0RTQWxWQ2dG4sb1/f
         92PA==
X-Gm-Message-State: APjAAAVoV2D13qDHgzrXJ8O4AiOnO7JlZZfQ/40JjmosElkCfPpyl5RA
        TC+vbQ9TYVd7ycjRBTtoU/WfaQ==
X-Google-Smtp-Source: APXvYqzcmnTEOiuKSt7BT2tO2CZWNSW1Cst0QeV7AzXL8vZ26nPCMzLc9eVwAlMHXVXLysywqp/i0A==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr42557480plq.335.1571242585996;
        Wed, 16 Oct 2019 09:16:25 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e10sm34459145pfh.77.2019.10.16.09.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:16:25 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: sm1: add audio support
In-Reply-To: <20191009082708.6337-1-jbrunet@baylibre.com>
References: <20191009082708.6337-1-jbrunet@baylibre.com>
Date:   Wed, 16 Oct 2019 09:16:24 -0700
Message-ID: <7h7e54hdif.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds audio support on the sm1 SoC family and the
> sei610 platform

Queued for v5.5.

> Kevin, The patchset depends on:
>  - The ARB binding merged by Philipp [0]
>  - The audio clock controller bindings I just applied. A tag is
>    available for you here [1]

I've pulled both of those into v5.5/dt64 so that branch is buildable
standlone.

Thanks for details on the dependencies.

Kevin
