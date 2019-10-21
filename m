Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6498DF09C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfJUO5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 10:57:19 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:28712 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:57:19 -0400
Date:   Mon, 21 Oct 2019 14:57:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571669837;
        bh=KAJiWEqfYk4ObHo7dRqzN/kAKbSxZxutAhS4sCKlRGU=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=ovKKaazuTF4UdOwiaqEWhVlsesxWV6/QGMArFH0/acDH/uC1lx62VM/qaKNySGq81
         8YzbK397WYQkL6HC19Bb5rfOuMsBnc4duAY4kDHSv4+jsXW2yXw8BjBLxvWyYXjbsn
         LG29rvOEnW65mgu6eVHtpb4SpapwuvaFvG1K4nj0=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: inner loop optimization and lists
Message-ID: <vDt3wmomD_VZN1fW-frH-gRSBtStKraPdbS5aWoST27_IOFsZU0PPieTd7PlZ8dDbRPeetnju62lfS_sKAu_955acdwv43WaYzC9X14Kr9k=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes one uses lists and checks if listitem needs to be run.

Instead of:

list:
=09   if nec do item1
=09   if nec do item2
=09   if nec do item3
=09   if nec do item4
=09   if nec do item5
=09   if nec do item6

and many checks.

do $selfmod_adress.

And just update address on interals.

Something like that?

A little afterthough on my jitter thinkings here on LKML.

Peace.
Ywe C=C3=A6rlyn (Varanger O.S.)
https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol_Q



