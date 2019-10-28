Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5978AE7943
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfJ1Tcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 15:32:47 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36613 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbfJ1Tcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:32:46 -0400
Received: by mail-wm1-f49.google.com with SMTP id c22so165669wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9hHVMUPScWA9p0edtvl4OSplyE525X8If3YYHyAoBsg=;
        b=BnjEv6k2DPgHOtK6dzkEHZ/6VJHsUk3BhMIYI2Lka+NyUIB908bYXsnON6WQpPNrzM
         Sc7Vxzuy61aPvXRsAQbGSVl8/ERDZpGisMn+BPMwSQN2qGhJbJwEZjRtYiMG84PkKlBQ
         Pfb5AQnTWBqgpM9ZPn3uVI6cH0tpa6qr1Ikxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9hHVMUPScWA9p0edtvl4OSplyE525X8If3YYHyAoBsg=;
        b=d8qKIXFF/8SJ+QaYKtqWD5Un1V16XZtVUCjHA8gE1GbdWRLODmJDbGCJbZu5Kfw+S3
         d83+ZUKBCivzyaHzMdT1SnVdbVg8fNdDT3UCQiPMYqfoKOTyIo53Q62pbB+VThwOEoPF
         FCTqfc+94YJtfAlaQnbYhNNo7AkyxxhUQ9TdR5WumSrVtBUJyzeWvLT4KcNEaUjSuOAG
         RvPeFYfimSQk+dGX8FerhRkQ0BsiGPSZjv9i+hWG/zM2AOIweONaRVqRI6sQ/JHPeFld
         HbG1EHOtVlgcb2/5S+26D1MFAnEG2La0CZ6EByIDuV66KEdZrpbUbO2hHz+kn0H1AYWr
         Dk3A==
X-Gm-Message-State: APjAAAWupI11DDq7dJ9jyoUtKvoHggy5W/GldXUh7c7Y9r7aObXEV77f
        dpl+HdWV34WXEIZeVvSUocdxQHFgIhRNxHA2
X-Google-Smtp-Source: APXvYqzP+GtzCEn3dB8WMT7Qr9gfXo/78jAWJKBJdK3mPsm5WP+yqF7Z0EnfRMO4aztOA49EusgzMg==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr799019wmd.104.1572291164041;
        Mon, 28 Oct 2019 12:32:44 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id e24sm634279wme.26.2019.10.28.12.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 12:32:43 -0700 (PDT)
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.co>
Cc:     linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: detecting misuse of of_get_property
Message-ID: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
Date:   Mon, 28 Oct 2019 20:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just spent some time trying to convert some so far PPC-only drivers to
be more generic. One of the things I had to do was convert stuff like

  u32 *val = of_get_property(np, "bla", NULL);
  do_stuff_with(*val);

with

  of_property_read_u32(np, "bla", &val);
  do_stuff_with(val);

(error checking omitted for simplicity). The problem is that
of_get_property() just returns void*. When the property is just a
string, there's no problem interpreting that as a char*. But when the
property is a number of array of numbers, I'd like some way to flag
casting it to u32* as an error - if you cast it to a (pointer to integer
type wider than char), it must be to a __be32*. Is there some way
sparse/smatch could help find such cases?

Rasmus
