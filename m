Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4186162A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 17:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBRQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 11:19:24 -0500
Received: from gentwo.org ([3.19.106.255]:41640 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgBRQTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:19:24 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 9F8263E998; Tue, 18 Feb 2020 16:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 9EA5C3E997;
        Tue, 18 Feb 2020 16:19:23 +0000 (UTC)
Date:   Tue, 18 Feb 2020 16:19:23 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     "Tobin C. Harding" <tobin@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tools: vm: slabinfo: Replace tabs with spaces
In-Reply-To: <20200217084828.9092-2-tobin@kernel.org>
Message-ID: <alpine.DEB.2.21.2002181619030.20682@www.lameter.com>
References: <20200217084828.9092-1-tobin@kernel.org> <20200217084828.9092-2-tobin@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020, Tobin C. Harding wrote:

> Replace the tabs with spaces, correctly aligning all option description
> strings.

Acked-by: Christoph Lameter <cl@linux.com>

