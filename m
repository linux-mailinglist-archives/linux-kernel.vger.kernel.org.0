Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11779CDA90
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 05:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfJGDJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 23:09:43 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:34511 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfJGDJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:09:43 -0400
Received: by mail-qt1-f174.google.com with SMTP id 3so17257790qta.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=W14yCSJnLEeJlMuUHDlOsJ4fIgi2Fh7HrjNFt4NgDo8=;
        b=mISM1LLhM+6stoZqG3aBZzsylV1n5vHnsdiJfc+VaZxG4c6yrTuNqs5D7zQgKyCNpI
         kaXxldECAl+nS+8FO+3CgPVrFLVAgo8j7lt7uBsTmTMbpwGy/OSiDh/D0cwlv/R4DT0D
         ++ltqghfqZsBsxkdiwpL+FrTJVEQu/yovEIeMyj/FWoBDcEn76c8NKJCUCyVUqBlRRBc
         CDeBnK8XJJ7fhbwMUI8SSVGLfzwQN51gipErfF7Jh5rHc858OO01L8gmMzS7XcGv3Q/T
         cn90HIQh07ai9v5z19sc6vNbWF+xVIChhZF4MbaIOAsnbeCjO49+kda6WqSoFtoNRKaR
         hyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=W14yCSJnLEeJlMuUHDlOsJ4fIgi2Fh7HrjNFt4NgDo8=;
        b=bUAMN/7NRw/7GV/2Dypp1UizWPusDvjp0EUGRgj7LG84osDpW8X1W+vbQ7p9K/rztj
         nT/vVa3xBzWaQHBzG3rdBrCnRa3KBRsoQngs1hYdoVHukwyvmBuWWVpu+hehuo1Rj4bn
         3zQxo3u+SJH9qMPvVB32p6pdznw13jfB+exHBvl6vB4TCn5lISQ7cF8OjsglMi3QvyvF
         tgzIP32ZYgBcEoLHfSGA2tUyZOWxlFZ50gjkBvG3drgBo7nPLV+sYa16EV21RNg0zj9O
         ibQrvNcO4tCCv3zsR0+IIpCSyvQborNNMCA16yy9im4vMH9wn32e9lZT6bLmFpnL1W6c
         Gjgg==
X-Gm-Message-State: APjAAAWrnZO0k1Wz5fcj+PYj60uXcKgY4YwYjlUKnizTHG+3780lf82E
        LJiqcOksYXnkbscyb39Eg5ASlPsAQ90=
X-Google-Smtp-Source: APXvYqz5QKq2ej4PYOV/qE66YTTGN6iMZRAeDANPrqM6xlVC7jGsCMlUTcPJfsbVDGARPfTyNwgvUg==
X-Received: by 2002:ac8:4304:: with SMTP id z4mr27280929qtm.160.1570417782108;
        Sun, 06 Oct 2019 20:09:42 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q2sm6745788qkc.68.2019.10.06.20.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 20:09:41 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 6 Oct 2019 23:09:39 -0400
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: kexec breaks with 5.4 due to memzero_explicit
Message-ID: <20191007030939.GB5270@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, arch/x86/purgatory/purgatory.ro has an undefined symbol
memzero_explicit. This has come from commit 906a4bb97f5d ("crypto:
sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
according to git bisect.

The patch mentions that it impacts purgatory code, but I don't see any
changes to actually include the definition of memzero_explicit into
purgatory? It used to get memset from arch/x86/boot/compressed/string.c
I think.
