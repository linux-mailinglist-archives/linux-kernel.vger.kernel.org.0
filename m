Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16EADACC08
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 12:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfIHK0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 06:26:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35341 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfIHK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:26:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so7343422pfw.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=QkYYXMpSNzYAnXgT92Zqaztp/WQ//k/Zbw8sD1YwIE8=;
        b=TDtjLmzMzMYUfGwCMnhxO8O68VZwGA06WS3pvGHpJqsOXHxl0HEZXIiOQMdco1POrN
         i9ITIc5mJhwJH39EMsgsD7mckU7IOT6B74aBSrVmtFEQQDfepcTJvqdjJl1KGzN1Ydz2
         LUqgw7lVjf71lx3baw8ZwhYayNgXNpA1Vg0b60IqF0mZfq+RrVaVfNCgQwEbQtTYrbiM
         mTJhaefFi9EyMQib8v1PXkkHkO/p2T8VTWS19T3B15/W3x2iwUAUoWT9UYI96W4CCfMt
         HoG6ep48TeyhkzeEog9PpisbiONJ5kVF82qZvC8LO7cNaOj7CkwhLfmODp4wM9xRLMMK
         9zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=QkYYXMpSNzYAnXgT92Zqaztp/WQ//k/Zbw8sD1YwIE8=;
        b=Q5sikDjmN6zL1OJfZ6G5emXr4oOiFKjXQoERmOLPlfT2OBtPUvIC9+4e1YLa48TGa3
         +Y2coPjtfGc0Za4iB7tIYU4LZ3ef5hBj04ciOI9b2+loOBnqPUunXugX+oHZxIqwMsIg
         iznjQ0I7y/efDqDf5Omdfd7dLVFB1A4iUUNxkxrfTjePEuA2M8A1bpAK0kpVgwS5iAcR
         v8PV7Ik3d3FPWs3kaqn2KbNtxv3gW6UQrqUUSQJF3RGBlq1mvAUSSz489pDeX1BF1mJz
         TqLTHLHJid8prjOskYNMcisKa0A2qYdDesBYE8oTCFEJ+x8i7jJgAvoVabwx7UAlEmIw
         bBGg==
X-Gm-Message-State: APjAAAWmMUgK09nVfn2fDYAyb+/6QYhpAoH5fVLofRaS7Sc1Uo8nq4Gk
        y1XrqphBt1A3Jm0NWJRLX7ZJWN6W
X-Google-Smtp-Source: APXvYqyRDujvoPwW9nBBykdDv2L/FTGwjyNT49Y0aRum4eOgjc4JqeQa/t7frZl/oUw2wcLNxwXXsw==
X-Received: by 2002:a62:583:: with SMTP id 125mr22057982pff.69.1567938403196;
        Sun, 08 Sep 2019 03:26:43 -0700 (PDT)
Received: from localhost ([203.63.189.78])
        by smtp.gmail.com with ESMTPSA id u21sm10258837pjn.5.2019.09.08.03.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:26:42 -0700 (PDT)
Date:   Sun, 08 Sep 2019 20:25:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/3] powerpc/ftrace: Enable
 HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1567707399.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1567707399.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1567937945.w0h0w8qaz6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen N. Rao's on September 6, 2019 4:20 am:
> Enable HAVE_FUNCTION_GRAPH_RET_ADDR_PTR for more robust stack unwinding=20
> when function graph tracer is in use. Convert powerpc show_stack() to=20
> use ftrace_graph_ret_addr() for better stack unwinding.

This series improved my case of a WARN_ON triggering in=20
trace_graph_return, the last return_to_handler entry in the stack
dump has the caller in parenthesis rather than return_to_handler.

It gives the caller, it would be nice if it could output the actual
function being traced, and then continue the caller. But at least
this is a significant improvement. Thanks for the quick turnaround.

Tested-by: Nicholas Piggin <npiggin@gmail.com>

=
