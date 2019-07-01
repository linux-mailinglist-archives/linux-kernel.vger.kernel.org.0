Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6569C222B5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 11:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfERJdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 05:33:16 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33788 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:33:15 -0400
Received: by mail-wr1-f43.google.com with SMTP id d9so9515655wrx.0;
        Sat, 18 May 2019 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bSU0pmO8NA8IzEC9ClUfFdwoeSvR32FualisGvPyxwY=;
        b=eSQvHrjj8bgcs7NAMEXZKljlMX2NlZ7hTAXzlzOCOfq0WLDaWOStrbxZpAQciau4AH
         Hofq5HQyPf9QMkyYZusn5wsxs2P6xkyknZsxcNF4V8wGNfXW1Fv1l4oc5pI+zIzXYqqm
         E34VmXXhgwqks4cRA4dBqDQtt6O8lTOrFBgl305nxWFoSOIuQE+8sVa3W67vu/cGYMrd
         GnhHlDwCWJqc6B6HGh0srmV8XQa/6UYUC5bsM4qp+fdggKGIGSC97NoqJ0hlGp4cE/wQ
         Oh32/n2Mk52aWDGkAYEBq8gIfnDYplIhaEFKXP4oCNhfpc87gG+vzXDImC+J0HzgYUjK
         zafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bSU0pmO8NA8IzEC9ClUfFdwoeSvR32FualisGvPyxwY=;
        b=AuXLEe5O/jxU1e4XrkOi/GQguvDnj/pnyfwjS2i3f5C6WwUchBVqDk8U6bdnElEL03
         S3YGZ+7Ng46Adz2s5U8hXSAUZbk0gLDUrM0pmQHc1L7yQR207hSJkiLMSA5n1TEJHVe+
         tMx8FfOjBtlCQs8dQwpjjPJAKCZnGPydSM9fnA3wa7nVhVh7Yshmcm/CcFrsSIviClpZ
         jdzm02SinBrg9TjKyiAOLerHuD7/uDVDDDN38iSL1FcjIr11plB+G5D+rC9V0ezvLZzI
         O4cAmdbwYRvR1X5XDi+cdgOtsxEH36SyOTmekEgTBCffqlRp2rEJMM07AWags1wfeKuG
         qnzw==
X-Gm-Message-State: APjAAAXLac18tHsj72F8+3o2fFc79NlmB49Tg0e68XNOG4txBxBqRgG8
        NrXB+eeI/8HoXrdEPzFBtI/gmpw=
X-Google-Smtp-Source: APXvYqyG77S+GaIqcr0esZDANRjcdxjNUbmsW01PA5DFxPgZt9QopjaMTJIO+gfqGT08yIHVTX5wew==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr26086276wrt.164.1558171994104;
        Sat, 18 May 2019 02:33:14 -0700 (PDT)
Received: from avx2 ([46.53.249.58])
        by smtp.gmail.com with ESMTPSA id j206sm12851622wma.47.2019.05.18.02.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 02:33:13 -0700 (PDT)
Date:   Sat, 18 May 2019 12:33:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     axboe@kernel.dk, ming.lei@redhat.com, osandov@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Setting up default iosched in 5.0+
Message-ID: <20190518093310.GA3123@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0 deleted three io schedulers and more importantly CONFIG_DEFAULT_IOSCHED
option:

	commit f382fb0bcef4c37dc049e9f6963e3baf204d815c
	block: remove legacy IO schedulers

After figuring out that I silently became "noop" customer enabling just
BFQ didn't work: "noop" is still being selected by default.

There is an "elevator=" command line option but it does nothing.

Are users supposed to add stuff to init scripts now?
