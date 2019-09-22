Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C99BA359
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 19:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfIVRcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 13:32:46 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:37907 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfIVRcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 13:32:45 -0400
Received: by mail-qk1-f179.google.com with SMTP id u186so12963721qkc.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uevSYwOhsO3ZIu8FEqA5BNX68Qgqmu7U7NQD7Y3Ecms=;
        b=YzG6sUxO4F1tUjdLZq85PFNuJDFKj4dQ6V3ekK99V2Ig+7USUHa0xs/ZRZb0SbnXCG
         Pb6xvHFDvOg+t287SPkPcp070ETUxOA96xXLFs0DzVrI9Xy7ozp3P7pTjenoZyUjBKjy
         3vXsT43TY54kI+Ac8Q16jn48zIFJ4dOoLZaAJBddxje1dLEKaSUj2ROZdp7w8Ujfb1E2
         AIOWjFmcOwtKYyvfgVjiUyPUH+9RFvhxFZYvOiaSNgs6n9t10tZa6klkrDuzm7XqNyI/
         iQwMf7tSxB0d9U+VYSqAxbLxAFRlRobpu+cRkGSwaYfDrLliu/1QifdAs106A2FfOYDN
         zkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=uevSYwOhsO3ZIu8FEqA5BNX68Qgqmu7U7NQD7Y3Ecms=;
        b=qFaDE5ZUDJe1mTpXKSwLuzoMQn7eGevy5NywIHi+P8wWQNXyQW8PpbTtlhbThruisr
         sekvJDvX2HBlsagoQ+ptOCsVXKPpR1d9gR7dk/deDVtKBR3wp49WAH17RPM2R7pgThHs
         czwst/dGLYMDbTUNC+VHMVl0jTPwi0X3pwv6PTnQYN5E13fVAPea1KXGRfSp9+Qk8zX9
         bSGxT0r/wRAku9bT06bPpQHZNXizNeg9zH9Zl5RlZcaerQyyJNEZaenvZxHECZ01YLbS
         Yxt4uwFphvKEjI85cboTNcrf0fo0wGFhf3JJl7JYdRjlRe+FjZnjfTXdmRppDFRLtc8L
         +uHg==
X-Gm-Message-State: APjAAAWH0A7JzigSQRMErUAPYSdH1ZlrYGVOmnL9CYS7up6tNKK/VbEK
        574JUiy6uwEBKyHaMPPxtMf31xpYBHE=
X-Google-Smtp-Source: APXvYqw1ioprSH7qV/hE8mJxzxySQS74umuFBim2onE0AcNjR2l1msiWZvaBLR16gRDhnJb0YmLtzQ==
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr14091407qkk.353.1569173564223;
        Sun, 22 Sep 2019 10:32:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x12sm5216163qtb.32.2019.09.22.10.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:32:43 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 22 Sep 2019 13:32:42 -0400
To:     linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>
Subject: kexec broken with STACKLEAK enabled
Message-ID: <20190922173241.GA44503@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, since commit b059f801a937 (x86/purgatory: Use CFLAGS_REMOVE rather
than reset KBUILD_CFLAGS) kexec is broken if GCC_PLUGIN_STACKLEAK is
enabled, as the purgatory contains undefined references to
stackleak_track_stack.

Attempting to load a kexec kernel results in an error:

	kexec: Undefined symbol: stackleak_track_stack
	kexec-bzImage64: Loading purgatory failed

Adding $(DISABLE_STACKLEAK_PLUGIN) to PURGATORY_CFLAGS in
arch/x86/purgatory/Makefile fixes this.

Not sure if that's the best fix or if other architectures also require a
similar one.

Thanks.
