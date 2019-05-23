Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20528B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 22:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbfEWU3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 16:29:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39290 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387834AbfEWU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:29:39 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so10482431itf.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=b890wSvSu6wn7E/uDIjk2vqaDgCqNzWOhAkC3m9/u2s=;
        b=Oh21H9o532d2n/TnnynzsE2ljIHzgvh1GxeZTfW2qHwe3qovfNr5GvwkMjmzzVASMz
         Ia9juX5Ktr3S8qTF/YJHNxCt6CaUVoykR+EYa013yQLepgHgtg0j0znllhIvqIAShZDw
         4WUocTAH0WMfZVqIMAevGQTiRV3Q7Wo1FYCD7Idb8bWJrytQ9B+mCrvaW/Y9kb3ddC8w
         qi0s1otayOcCHqXNqVEvIuOiPH3oe2ibsYGcrmU1UywHhpLR8LdjYq0apUM74Ra8RS3F
         T+zDEyFLJBLLEUvOaReB2N4eiDd3iTFZgg/vvjmfyoNCZXwF2JsBICr3Dggkrv/bqkih
         e3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=b890wSvSu6wn7E/uDIjk2vqaDgCqNzWOhAkC3m9/u2s=;
        b=T+rWsxoqC/hyXyx/zQ6Mu1bHx1Y9yJosMqRCh1yvHDx7XQ8JjGzRTZAvvs9+vtqwdi
         ww+s6FsBe9ginLk0Pahtj+TDDHU6V4sdxim9OZRpS9/REoPFgpJgxN6tidhWwnUU6Cro
         fmTHta0eIIDhye34geTHV33sjMDx8y7ByJwjIP5ksyOAOJGUWji4hWB/YF4KfKOpGmyf
         bkITDx/K6QRCfd6AjRhwsjVQq8RmhLj5OzuwXeg824+MctHmkljgcxXHAOYjTLcRzD9P
         PSHqP806meigg0IuYh6NMLBV5DuPlERDwJFZQ6gl98HFQhtGt29+plKXgAVjsKblvH8n
         jLIg==
X-Gm-Message-State: APjAAAVqAQWHJ9enNNcODV+lxgZOGWF52MBq3cNzFwHxv5+9NiTv5580
        hDynmZA6igGVoSbz3JjqGaDvpw==
X-Google-Smtp-Source: APXvYqwoBcWiq9kt8e9AFxHiOgATa2Rx2JHeWpNLhTfaKeetKbRVbLGHjaraqPj3ixUZof8y8n2B5A==
X-Received: by 2002:a24:d43:: with SMTP id 64mr7541897itx.114.1558643378930;
        Thu, 23 May 2019 13:29:38 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id i25sm194019ioi.42.2019.05.23.13.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 13:29:38 -0700 (PDT)
Date:   Thu, 23 May 2019 13:29:37 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alan Mikhak <alan.mikhak@sifive.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com
Subject: Re: [PATCH 1/2] tools: PCI: Fix broken pcitest compilation
In-Reply-To: <1558642464-9946-2-git-send-email-alan.mikhak@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1905231329130.31734@viisi.sifive.com>
References: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com> <1558642464-9946-2-git-send-email-alan.mikhak@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019, Alan Mikhak wrote:

> From: Alan Mikhak <alan.mikhak@sifive.com>

Please drop this line.

> Fixes: fef31ecaaf2c ("tools: PCI: Fix compilation warnings")

This goes down below with the Signed-off-by: lines.


- Paul
