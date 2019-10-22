Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A710E0783
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfJVPeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 11:34:18 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37855 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbfJVPeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:34:18 -0400
Received: by mail-lj1-f179.google.com with SMTP id l21so17708724lje.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vrZdqdtC8XrSKWGebDbH0E8DWpZktikSIOmUKayMJSs=;
        b=vO4fCnpnXOmKgfQ8+PcNaNqWl8ono9AF5O322fsUXOSsmlYqmGXA48RJ27wPesqr+b
         D5/6fgIlpfUUkIijEMR961sYz3o2GjaQ6ErvRhnE4PUGcmUHD778x+EF+UCeQoHw/WGT
         dPP7xlukHBjr9bSaMRymfQW08FbuuESK1TG9+h4ltM/YxhUOQjmM9lxcfNBLT3S6SyFE
         ut3qU+haB9WqFtaBSaso7s/1Xl/gsAoJMYdLiRonKrqU0iplwKJsqtWEJ3Gp2urcIWkp
         KX1iwMf/0lzGfaWf2eCF83y+IA2xAe7mzDdgFPHdsRPfqeWDk5zn91JN1Z/LgNRCV6oH
         nJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vrZdqdtC8XrSKWGebDbH0E8DWpZktikSIOmUKayMJSs=;
        b=OEf9AwWdFuA6DzcpaGp1DgkhltVLEkICedrT19CPutKP6ikxmZuuxuK/XXDdDD1xEY
         am8DvQa8/x8fSzZm3c5pCddKZZoCXBt0tL6R6d62JRK76FaXqBYZpMLj1kpMWNTHT8Bl
         gfhNXCbDlWF3NGDA+oVn3byhADeFWAumpMnZ0vg76V1gapNHf4npOy4CANymv14z473R
         IykuVGsLsXGG3PU7zaZgom7TaNoP/PCT5MGjepMOw004XBfHpdSbpVkkrlw5wyexB8Xr
         Gi3kG5lIA3Ba2wRu7c+Bfr3b1MkjiVfPQCEl/E+iI1+U1suDCXU2Ev4YcsMoSqX7CmIB
         U6bA==
X-Gm-Message-State: APjAAAXTu8chFwSRwcDRTMsDSS/p0raSjJJ6GnXpUkOKm4sqoltrTKV6
        5FILSeRyiHFrYIRZUsdrt+CWevr+WGlHacBlrzAV/A==
X-Google-Smtp-Source: APXvYqwmEMS1tSpmgcZ+YU0BkObEGNT9YuyirSe2hFYK6SRjl/1MeCdkBRtdLZRvyzkv05iBIjAuvCbrdcb7WPf7Xuc=
X-Received: by 2002:a2e:5354:: with SMTP id t20mr19254053ljd.227.1571758456189;
 Tue, 22 Oct 2019 08:34:16 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Oct 2019 21:04:04 +0530
Message-ID: <CA+G9fYvWdkmmkrq7hvADZ-1qnUNEwRULoTPfOQDnu1aZW8cDEA@mail.gmail.com>
Subject: Linux-next: 20191022: perf: bpf_helpers_doc.py: not found
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        acme@kernel.org, open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have noticed perf (OE recipe) build failure on linux next 20191022.
do you see this failure ?

/bin/sh: 1: perf/1.0-r9/perf-1.0/scripts/bpf_helpers_doc.py: not found
Makefile:184: recipe for target 'bpf_helper_defs.h' failed
make[3]: *** [bpf_helper_defs.h] Error 127
make[3]: *** Deleting file 'bpf_helper_defs.h'
Makefile.perf:765: recipe for target 'perf/1.0-r9/perf-1.0/libbpf.a' failed
make[2]: *** [perf/1.0-r9/perf-1.0/libbpf.a] Error 2

Metadata:
------------------------------------------------------------------------
kernel: 5.4.0-rc4
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: a722f75b2923b4fd44c17e7255e822ac48fe85f0
git describe: next-20191022
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191022

Full build log:
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/631/consoleText

- Naresh
